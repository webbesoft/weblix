defmodule TestMaverickHttpServerTest do
  use ExUnit.Case
  doctest TestMaverickHttpServer

  test "greets the world" do
    assert TestMaverickHttpServer.hello() == :world
  end
end
