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

  @single_response %Finch.Response{
    status: 200,
    body:
      "{\"Title\":\"Superman\",\"Year\":\"1978\",\"Rated\":\"PG\",\"Released\":\"15 Dec 1978\",\"Runtime\":\"143 min\",\"Genre\":\"Action, Adventure, Sci-Fi\",\"Director\":\"Richard Donner\",\"Writer\":\"Jerry Siegel, Joe Shuster, Mario Puzo\",\"Actors\":\"Christopher Reeve, Margot Kidder, Gene Hackman\",\"Plot\":\"An alien orphan is sent from his dying planet to Earth, where he grows up to become his adoptive home's first and greatest superhero.\",\"Language\":\"English\",\"Country\":\"United States, United Kingdom, Switzerland, Panama\",\"Awards\":\"Nominated for 3 Oscars. 19 wins & 23 nominations total\",\"Poster\":\"https://m.media-amazon.com/images/M/MV5BMzFlZDJjMDAtZDYxZS00NzZhLTk2ODMtZWRlODA3Njk3ZTdmXkEyXkFqcGc@._V1_SX300.jpg\",\"Ratings\":[{\"Source\":\"Internet Movie Database\",\"Value\":\"7.4/10\"},{\"Source\":\"Rotten Tomatoes\",\"Value\":\"93%\"},{\"Source\":\"Metacritic\",\"Value\":\"82/100\"}],\"Metascore\":\"82\",\"imdbRating\":\"7.4\",\"imdbVotes\":\"191,580\",\"imdbID\":\"tt0078346\",\"Type\":\"movie\",\"DVD\":\"N/A\",\"BoxOffice\":\"$134,478,449\",\"Production\":\"N/A\",\"Website\":\"N/A\",\"Response\":\"True\"}",
    headers: [
      {"date", "Sat, 21 Dec 2024 18:14:07 GMT"},
      {"content-type", "application/json; charset=utf-8"},
      {"content-length", "1018"},
      {"connection", "keep-alive"},
      {"cache-control", "public, max-age=86400"},
      {"expires", "Sat, 21 Dec 2024 19:14:07 GMT"},
      {"last-modified", "Sat, 21 Dec 2024 18:14:07 GMT"},
      {"vary", "*"},
      {"x-aspnet-version", "4.0.30319"},
      {"x-powered-by", "ASP.NET"},
      {"access-control-allow-origin", "*"},
      {"cf-cache-status", "MISS"},
      {"accept-ranges", "bytes"},
      {"server", "cloudflare"},
      {"cf-ray", "8f59d9973d3f2ec9-LAX"}
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

  test "get_by_title" do
    expect(Finch, :request, fn req, Omdb.Finch ->
      assert req.scheme == :http
      assert req.method == "GET"
      assert req.path == "/"
      assert req.host == "www.omdbapi.com"
      query_params = URI.query_decoder(req.query) |> Enum.into(%{})
      assert query_params["apikey"] == "fakekey"
      assert query_params["t"] == "superman"
      {:ok, @single_response}
    end)

    {:ok, res} = Omdb.get_by_title("superman", apikey: "fakekey")

    assert res["Title"] == "Superman"
  end

  test "get_by_id" do
    expect(Finch, :request, fn req, Omdb.Finch ->
      assert req.scheme == :http
      assert req.method == "GET"
      assert req.path == "/"
      assert req.host == "www.omdbapi.com"
      query_params = URI.query_decoder(req.query) |> Enum.into(%{})
      assert query_params["apikey"] == "fakekey"
      assert query_params["i"] == "tt0078346"
      {:ok, @single_response}
    end)

    {:ok, res} = Omdb.get_by_id("tt0078346", apikey: "fakekey")

    assert res["Title"] == "Superman"
  end
end
