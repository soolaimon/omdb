defmodule OmdbTest do
  use ExUnit.Case
  doctest Omdb

  test "greets the world" do
    assert Omdb.hello() == :world
  end
end
