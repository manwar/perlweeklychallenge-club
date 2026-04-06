#!/usr/bin/env elixir

defmodule PWC do
  import Enum
  import String, except: [to_charlist: 1] # keep Kernel.to_charlist/1

  def conflict([_ | stop], [start | _]) do
    stop  = hd(stop) |> replace(":", "") |> to_integer
    start = start    |> replace(":", "") |> to_integer
    stop > start
  end

  def quote_wrap(array) do
    array |> map(fn t -> "\"#{t}\"" end) |> join(", ")
  end

  def solution(event1, event2) do
    IO.puts("Input: @event1 = (#{quote_wrap(event1)})")
    IO.puts("       @event2 = (#{quote_wrap(event2)})")
    IO.puts("Output: #{conflict(event1, event2)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["10:00", "12:00"], ["11:00", "13:00"])

IO.puts("\nExample 2:")
PWC.solution(["09:00", "10:30"], ["10:30", "12:00"])

IO.puts("\nExample 3:")
PWC.solution(["14:00", "15:30"], ["14:30", "16:00"])

IO.puts("\nExample 4:")
PWC.solution(["08:00", "09:00"], ["09:01", "10:00"])

IO.puts("\nExample 5:")
PWC.solution(["23:30", "00:30"], ["00:00", "01:00"])
