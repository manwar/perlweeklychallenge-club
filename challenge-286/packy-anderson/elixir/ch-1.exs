#!/usr/bin/env elixir

{:ok, contents} = File.read(__ENV__.file)
word = contents
       |> String.split(~r{\s+}, trim: true)
       |> Enum.random
IO.puts(word)
