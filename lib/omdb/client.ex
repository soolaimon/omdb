defmodule Omdb.Client do
  @base_url "www.omdbapi.com/"
  @image_url "img.omdbapi.com/"

  @spec search(String.t(), keyword()) :: {:ok, map()} | {:error, String.t()}
  def search(query, opts \\ []) do
    res =
      opts
      |> Enum.into(%{})
      |> Map.merge(%{t: query})
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
