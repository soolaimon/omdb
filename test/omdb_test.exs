defmodule OmdbTest do
  use ExUnit.Case
  doctest Omdb

  @search_response %Finch.Response{
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
    Omdb.search("superman", apikey: "")
  end
end
