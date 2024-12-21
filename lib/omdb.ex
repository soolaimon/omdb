defmodule Omdb do
  @moduledoc """
    A Thin Wrapper for the OMDB API. Functions map to requests documented
    here: Get a movie, series, or episode by title.

  """
  alias Omdb.Client

  defdelegate search(query, opts), to: Client
  defdelegate get_by_title(title, opts), to: Client
  defdelegate get_by_id(title, opts), to: Client
end
