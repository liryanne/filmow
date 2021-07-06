defmodule Filmow.CLI do

  def main(args \\ []) do
    args
    |> parse_args()
    |> response()
    |> IO.puts()
  end

  defp parse_args(args) do
    {opts, word, _} =
      args
      |> OptionParser.parse(switches: [upcase: :boolean, random: :boolean])

    case opts do
      [upcase: true] -> {:upcase, List.to_string(word)}
      [random: true] -> {:random, List.to_string(word)}
      _ -> :invalid_arg
    end
  end

  defp response({:upcase, word}) do
    String.upcase(word)
  end

  defp response({:random, username}) do
    Filmow.get_random_movie(username)
  end

  defp response(:invalid_arg) do
    IO.puts "Invalid argument(s) passed."
  end
end
