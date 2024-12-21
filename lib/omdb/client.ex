defmodule Omdb.Client do
  @base_url "www.omdbapi.com/"

  @type title_type() :: :movie | :series | :episode

  @type opt() :: {:type | title_type()} | {:api_key, String.t()}
  @type resource_opt() :: {:plot, :short | :full} | opt()

  @type search_opt() :: {:page | integer()} | opt()

  @doc """
  Search for a movie, series, or episode. Returns paginated results of 10 per page.
  """
  @spec search(String.t(), [search_opt()]) :: {:ok, map()} | {:error, String.t()}
  def search(query, opts) do
    opts
    |> Enum.into(%{})
    |> Map.merge(%{s: query})
    |> url
    |> get()
    |> parse_response()
  end

  @doc """
  Get a movie, series, or episode by title.
  """
  @spec get_by_title(String.t(), [resource_opt()]) :: {:ok, map()} | {:error, String.t()}
  def get_by_title(title, opts) do
    opts
    |> Enum.into(%{})
    |> Map.merge(%{t: title})
    |> url
    |> get()
    |> parse_response()
  end

  @doc """
  Get a movie, series, or episode by its IMDB id.
  """
  @spec get_by_id(String.t(), [resource_opt()]) :: {:ok, map()} | {:error, String.t()}
  def get_by_id(title, opts) do
    opts
    |> Enum.into(%{})
    |> Map.merge(%{i: title})
    |> url
    |> get()
    |> parse_response()
  end

  defp get(url) do
    Finch.build(:get, url)
    |> Finch.request(Omdb.Finch)
  end

  defp parse_response({:ok, %Finch.Response{status: 200, body: body}}) do
    JSON.decode(body)
  end

  defp parse_response({:ok, %Finch.Response{status: status, body: body}}) do
    {:error, "HTTP Error: #{status} - #{body}"}
  end

  defp url(opts) do
    query = URI.encode_query(opts)

    %URI{
      scheme: "http",
      host: @base_url,
      query: query
    }
    |> URI.to_string()
  end
end
