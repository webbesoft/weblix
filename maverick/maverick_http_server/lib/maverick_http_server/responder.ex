defmodule Maverick.HTTPServer.Responder do
  @type method :: :GET | :POST | :PUT | :PATCH | :DELETE

  @callback resp(term(), method(), string()) ::
    Maverick.HTTPResponse.t()
end
