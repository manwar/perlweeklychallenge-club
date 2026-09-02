#!/usr/bin/env elixir

defmodule PWC do
  def reorder(melody) do
    # unpack data
    composer = Enum.at(melody, 0) |> String.upcase
    notes = Enum.at(melody, 1)
    order = Enum.at(melody, 2)
    # reorder data
    new = for _ <- 1..length(notes), do: nil
    new = Enum.zip(notes, order)
    |> Enum.reduce(new, fn {note, i}, new ->
      List.replace_at(new, i-1, note)
    end)
    |> Enum.join(" ")
    "#{composer} => #{new}"
  end

  def solution(melody) do
    # unpack data
    composer = Enum.at(melody, 0)
    notes = Enum.at(melody, 1) |> Enum.join(" ")
    order = Enum.at(melody, 2) |> Enum.map(&(Integer.to_string(&1))) |> Enum.join(", ")
    IO.puts("Input: $melody = ['#{composer}', [qw(#{notes})], [#{order}]]")
    IO.puts("Output: #{reorder(melody)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["Bach", String.split("C D E F# G A B"), [7, 1, 6, 2, 5, 3, 4]])

IO.puts("\nExample 2:")
PWC.solution(["Beethoven", String.split("C D F# G Ab"), [1, 3, 5, 2, 4]])

IO.puts("\nExample 3:")
PWC.solution(["Brahms", String.split("C Db Eb F G Ab Bb C D"), [9, 3, 7, 1, 8, 5, 2, 6, 4]])

IO.puts("\nExample 4:")
PWC.solution(["Bruckner", String.split("G F# Bb C D Eb F"), [4, 7, 2, 6, 1, 5, 3]])

IO.puts("\nExample 5:")
PWC.solution(["Berg", ["C#"], [1]])
