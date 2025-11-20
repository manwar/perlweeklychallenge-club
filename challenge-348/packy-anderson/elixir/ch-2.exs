#!/usr/bin/env elixir

defmodule PWC do
  def mytime(t) do
    {_, dt, _} = DateTime.from_iso8601("2000-01-01T#{t}:00Z")
    dt
  end

  def convert_time([], _, ops), do: ops
  def convert_time(_, diff, ops) when diff == 0, do: ops

  def convert_time([op | rest], diff, ops) do
    n = Integer.floor_div(diff, op)
    {diff, ops} = cond do
      n > 0 ->
        minutes = if op == 1, do: "minute", else: "minutes"
        {
          diff - n * op,
          ops ++ Enum.map(
            Range.to_list(1..n),
            fn _ -> "Add #{op} #{minutes}" end
          )
        }
      true -> {diff, ops}
    end
    convert_time(rest, diff, ops)
  end

  def convert_time(source, target) do
    s = mytime(source)
    t = mytime(target)
    t = if t < s, # it must be a time in the next day
      do: DateTime.add(t, 1, :day), else: t
    diff = DateTime.diff(t, s, :minute)
    ops = convert_time([60, 15, 5, 1], diff, [])
    count = length(ops)
    operations = if count == 1, do: "Operation",
                              else: "Operations"
    "#{count}\n\n#{operations}:\n + " <> Enum.join(ops, "\n + ")
  end

  def solution(source, target) do
    IO.puts("Input: $source = \"#{source}\"")
    IO.puts("       $target = \"#{target}\"")
    IO.puts("Output: " <> convert_time(source, target))
  end
end

IO.puts("Example 1:")
PWC.solution("02:30", "02:45")

IO.puts("\nExample 2:")
PWC.solution("11:55", "12:15")

IO.puts("\nExample 3:")
PWC.solution("09:00", "13:00")

IO.puts("\nExample 4:")
PWC.solution("23:45", "00:30")

IO.puts("\nExample 5:")
PWC.solution("14:20", "15:25")
