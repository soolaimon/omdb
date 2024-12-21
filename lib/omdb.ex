defmodule Omdb do
  @moduledoc """
  Documentation for `Omdb`.
  """
  alias Omdb.Client

  @doc """
  Hello world.

  ## Examples

      # iex> Omdb.hello()
      # :world

  """
  def search(query, opts \\ []) do
    Client.search(query, opts)
  end
end
