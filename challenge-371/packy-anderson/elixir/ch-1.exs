#!/usr/bin/env elixir

defmodule PWC do
  def ord(seq, i), do: to_charlist(Enum.at(seq, i)) |> hd

  # fill in the missing differences
  def missing_diff(diff, i) when i == 4, do: diff
  def missing_diff(diff, i) do
    if is_nil(diff[i]) do
      missing_diff(Map.put(diff, i, diff[rem(i+2, 4)]), i+1)
    else
      missing_diff(diff, i+1)
    end
  end

  # determine the differences we know
  def fill_in_diff(_, diff, i) when i == 4, do: diff
  def fill_in_diff(seq, diff, i) do
    if Enum.at(seq, i) == "?" or Enum.at(seq, i+1) == "?" do
      fill_in_diff(seq, diff, i+1)
    else
      diff = Map.put(diff, i, ord(seq, i+1) - ord(seq, i))
      fill_in_diff(seq, diff, i+1)
    end
  end

  def missing(seq, diff, i, [h | _]) when i == 0 and h == "?" do
    # special case: the first letter is missing
    ord(seq,1) - diff[0] |> then(fn x -> [x] end)
  end

  def missing(seq, diff, i, [h | _]) when h == "?" do
    # calculate the missing letter
    ord(seq,i-1) + diff[i-1] |> then(fn x -> [x] end)
  end

  def missing(seq, diff, i, [_ | t]) do
    missing(seq, diff, i+1, t)
  end

  def missing(seq) do
    diff = missing_diff(fill_in_diff(seq, %{}, 0), 0)
    missing(seq, diff, 0, seq)
  end

  def solution(seq) do
    IO.puts("Input: @seq = qw(" <> Enum.join(seq, " ") <> ")")
    IO.puts("Output: #{missing(seq)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["a", "c", "?", "g", "i"])

IO.puts("\nExample 2:")
PWC.solution(["a", "d", "?", "j" ,"m"])

IO.puts("\nExample 3:")
PWC.solution(["a", "e", "?", "m", "q"])

IO.puts("\nExample 4:")
PWC.solution(["a", "c", "f", "?", "k"])

IO.puts("\nExample 5:")
PWC.solution(["b", "e", "g", "?", "l"])

IO.puts("\nExample 6:")
PWC.solution(["?", "t", "v", "x", "z"])

IO.puts("\nExample 7:")
PWC.solution(["l", "m", "o", "p", "?"])
