#!/usr/bin/env elixir

defmodule PWC do

  def defang(ip) do
    Regex.run(
      ~r/(\d+)[.](\d+)[.](\d+)[.](\d+)/,
      ip,
      capture: :all_but_first
    )
    |> Enum.join("[.]")
  end

  def solution(ip) do
    IO.puts("Input: $ip = \"#{ip}\"")
    defanged = defang(ip)
    IO.puts("Output: #{defanged}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("1.1.1.1")

IO.puts("\nExample 2:")
PWC.solution("255.101.1.0")
