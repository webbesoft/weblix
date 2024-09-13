defmodule TestMaverickHTTPServer.Responder do
  import Maverick.HTTPServer.ResponderHelpers

  def resp(_req, method, path) do
    cond do
      method == :GET && path == "/hello" ->
        http_response("Hello World")
        |> put_header("Content-Type", "text/html")
        |> put_status(200)
      method == :GET && path == "/long-hello" ->
        # sleep for 10 seconds
        :timer.sleep(10000)

        http_response("Hello from the other side")
        |> put_header("Content-Type", "text/html")
        |> put_status(200)
      true ->
        http_response("Not Found")
        |> put_header("Content-Type", "text/html")
        |> put_status(404)
      end
  end
end
          