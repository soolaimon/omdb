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

  def get_by_title(title, opts \\ []) do
    Client.get_by_title(title, opts)
  end

  def get_by_id(id, opts \\ []) do
    Client.get_by_id(id, opts)
  end
end
