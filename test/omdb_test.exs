defmodule OmdbTest do
  use ExUnit.Case
  doctest Omdb

  test "search" do
    Omdb.search("superman")  |> dbg()
  end
end
