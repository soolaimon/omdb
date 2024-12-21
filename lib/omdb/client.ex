defmodule Omdb.Client do
  @base_url "www.omdbapi.com/"
  @image_url "img.omdbapi.com/"

  @type title_type() :: :movie | :series | :episode

  @type opt() :: {:type | title_type()} | {:api_key, String.t()} | {:year, String.t()}
  @type resource_opt() :: {:plot, :short | :full} | opt()

  @type search_opt() :: {:page | integer()}

  @spec search(String.t(), opt()) :: {:ok, map()} | {:error, String.t()}
  def search(query, opts \\ []) do
    res =
      opts
      |> Enum.into(%{})
      |> Map.merge(%{s: query})
      |> url
      |> then(fn url ->
        Finch.build(:get, url) |> Finch.request(Omdb.Finch)
      end)

    with {:ok, %Finch.Response{status: 200, body: body}} <- res do
      JSON.decode(body)
    else
      {:ok, %Finch.Response{status: status, body: body}} ->
        {:error, "HTTP Error: #{status} - #{body}"}
    end
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
