defmodule TestMaverickHTTPServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @port 4001

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: TestMaverickHttpServer.Worker.start_link(arg)
      # {TestMaverickHttpServer.Worker, arg}
      {Maverick.HTTPServer, [@port] }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestMaverickHTTPServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
