defmodule OmdbTest do
  use ExUnit.Case
  use Mimic
  doctest Omdb

  setup :verify_on_exit!

  @search_res %Finch.Response{
    status: 200,
    body:
      "{\"Search\":[{\"Title\":\"Batman v Superman: Dawn of Justice\",\"Year\":\"2016\",\"imdbID\":\"tt2975590\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BZTJkYjdmYjYtOGMyNC00ZGU1LThkY2ItYTc1OTVlMmE2YWY1XkEyXkFqcGc@._V1_SX300.jpg\"},{\"Title\":\"Superman Returns\",\"Year\":\"2006\",\"imdbID\":\"tt0348150\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BMjg1ZGRiMTEtYmU4Zi00NTkwLWJmODQtMjU3MTAyMGQ2OGZlXkEyXkFqcGc@._V1_SX300.jpg\"},{\"Title\":\"Superman\",\"Year\":\"1978\",\"imdbID\":\"tt0078346\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BMzFlZDJjMDAtZDYxZS00NzZhLTk2ODMtZWRlODA3Njk3ZTdmXkEyXkFqcGc@._V1_SX300.jpg\"},{\"Title\":\"Superman II\",\"Year\":\"1980\",\"imdbID\":\"tt0081573\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BNzg5ZjJkNGEtNzhjNy00YzI4LTlkZjItNTViNmYxNGZlZWE2XkEyXkFqcGc@._V1_SX300.jpg\"},{\"Title\":\"Superman III\",\"Year\":\"1983\",\"imdbID\":\"tt0086393\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BYjcyN2E4NzQtYmUwZC00NmQ5LWJkMWUtMThjZGIwZGIwYzZmXkEyXkFqcGc@._V1_SX300.jpg\"},{\"Title\":\"Batman v Superman: Dawn of Justice (Ultimate Edition)\",\"Year\":\"2016\",\"imdbID\":\"tt18689424\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BOTRlNWQwM2ItNjkyZC00MGI3LThkYjktZmE5N2FlMzcyNTIyXkEyXkFqcGdeQXVyMTEyNzgwMDUw._V1_SX300.jpg\"},{\"Title\":\"Superman IV: The Quest for Peace\",\"Year\":\"1987\",\"imdbID\":\"tt0094074\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BZjhkODhlYjEtMDEyZS00YjZmLWJjMDctZGI3MGJiNDEyNTE2XkEyXkFqcGc@._V1_SX300.jpg\"},{\"Title\":\"Superman/Batman: Apocalypse\",\"Year\":\"2010\",\"imdbID\":\"tt1673430\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BMjk3ODhmNjgtZjllOC00ZWZjLTkwYzQtNzc1Y2ZhMjY2ODE0XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg\"},{\"Title\":\"Superman/Batman: Public Enemies\",\"Year\":\"2009\",\"imdbID\":\"tt1398941\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BZDc5NTFiMzgtZWJiOS00N2M1LWJmOGYtZmNjMzFhMzcxZjRiXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg\"},{\"Title\":\"Superman: Doomsday\",\"Year\":\"2007\",\"imdbID\":\"tt0934706\",\"Type\":\"movie\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BMmJhN2RmMTUtMDMzMy00YTQ4LWEyZDMtOGM1NWVmMDE3NTBjXkEyXkFqcGdeQXVyNjExODE1MDc@._V1_SX300.jpg\"}],\"totalResults\":\"296\",\"Response\":\"True\"}",
    headers: [
      {"date", "Sat, 21 Dec 2024 21:06:32 GMT"},
      {"content-type", "application/json; charset=utf-8"},
      {"content-length", "2248"},
      {"connection", "keep-alive"},
      {"cache-control", "public, max-age=86400"},
      {"expires", "Sat, 21 Dec 2024 21:49:35 GMT"},
      {"last-modified", "Sat, 21 Dec 2024 20:49:35 GMT"},
      {"vary", "*"},
      {"x-aspnet-version", "4.0.30319"},
      {"x-powered-by", "ASP.NET"},
      {"access-control-allow-origin", "*"},
      {"cf-cache-status", "HIT"},
      {"age", "1017"},
      {"accept-ranges", "bytes"},
      {"server", "cloudflare"},
      {"cf-ray", "8f5ad62acc9c520e-LAX"}
    ],
    trailers: []
  }

  test "search" do
    expect(Finch, :request, fn req, Omdb.Finch ->
      assert req.scheme == :http
      assert req.method == "GET"
      assert req.path == "/"
      assert req.host == "www.omdbapi.com"
      query_params = URI.query_decoder(req.query) |> Enum.into(%{})
      assert query_params["apikey"] == "fakekey"
      assert query_params["s"] == "superman"
      {:ok, @search_res}
    end)

    {:ok, res} = Omdb.search("superman", apikey: "fakekey", type: :movie)
    assert res["Response"] == "True"
    assert Enum.count(res["Search"]) == 10

    expect(Finch, :request, fn req, Omdb.Finch ->
      query_params = URI.query_decoder(req.query) |> Enum.into(%{})
      assert query_params["page"] == "2"
      {:ok, @search_res}
    end)

    {:ok, _res} = Omdb.search("superman", apikey: "fakekey", type: :movie, page: 2)
  end

  test "by_title" do
  end
end
