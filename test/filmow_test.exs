defmodule FilmowTest do
  use ExUnit.Case
  doctest Filmow

  test "greets the world" do
    assert Filmow.hello() == :world
  end
end
