defmodule Maverick.HttpServer do
  @moduledoc """
  Starts an HTTP server on the given port

  This module als logs all requests
  """
  require Logger

  @server_options [
    active: false,
    packet: :http_bin,
    reuseaddr: true
  ]

  def start(port) do
    ensure_configured!()

    case :gen_tcp.listen(port, @server_options) do
      {:ok, sock} ->
        Logger.info("Started a webserver on port #{port}")

        listen(sock)

        {:error, error} ->
          Logger.error("Cannot start server on port #{port}: #{error}")
    end
  end

  defp ensure_configured! do
    case responder() do
      nil -> raise "No `responder` configured for `maverick_http_server"
      _responder -> :ok
    end
  end

  defp responder do
    Application.get_env(:maverick_http_server, :responder)
  end

  def listen(sock) do
    {:ok, req} = :gen_tcp.accept(sock)

    {
      :ok,
      {_http_req, method, {_type, path}, _v}
    } = :gen_tcp.recv(req, 0)

    Logger.info("Received HTTP request #{method} on #{path}")

    respond(req, method, path)

    listen(sock)
  end

  defp respond(req, method, path) do
    # Different for different apps
    %Maverick.HTTPResponse{} = resp = responder().resp(req, method, path)
    resp_string = Maverick.HTTPResponse.to_string(resp)

    :gen_tcp.send(req, resp_string)

    Logger.info("Request sent: \n#{resp_string}")

    :gen_tcp.close(req)
  end

  def responder do
    Application.get_env(:maverick_http_server, :responder)
  end
end
