defmodule MaverickHttpServerTest do
  use ExUnit.Case
  doctest MaverickHttpServer

  test "greets the world" do
    assert MaverickHttpServer.hello() == :world
  end
end
