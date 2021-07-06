defmodule Filmow do
  defp get_movies_page(page) do
    url = "https://filmow.com#{page}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, document} = Floki.parse_document(body)

        movies =
          document
          |> Floki.find(".movie_list_item a")
          |> Floki.attribute("title")
          |> Enum.uniq

        next_page =
          document
          |> Floki.find("#next-page")
          |> Floki.attribute("href")
          |> List.first

        %{movies: movies, next_page: next_page}

      _ -> :error
    end
  end

  defp get_list_movies(url, list \\ [], page \\ 1)

  defp get_list_movies(url, list, _page) when url == nil, do: list

  defp get_list_movies(url, list, page) do
    IO.puts "Page #{page}"
    %{movies: movies, next_page: new_url} = get_movies_page(url)
    get_list_movies(new_url, list ++ movies, page + 1)
  end

  defp get_movies(username) do
    IO.puts "listing movies..."
    get_list_movies("/usuario/#{username}/filmes/quero-ver/")
  end

  def get_random_movie(username) do
    movies = get_movies(username)
    IO.puts "-> #{Enum.count(movies)} movies"
    Enum.random(movies)
  end
end
