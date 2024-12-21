defmodule Omdb.Client do
  @base_url "www.omdbapi.com/"
  @image_url "img.omdbapi.com/"

  def search(query, opts \\ []) do
    opts
    |> Enum.into(%{})
    |> Map.merge(%{t: query})
    |> url
    |> then(fn url ->
      Finch.build(:get, url) |> Finch.request(Omdb.Finch)
    end)
    |> dbg()
  end

  defp url(opts) do
    query = URI.encode_query(opts)

    %URI{
      scheme: "https",
      host: @base_url,
      query: query
    }
    |> URI.to_string()
    |> dbg()
  end
end
