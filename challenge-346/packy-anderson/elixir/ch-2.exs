#!/usr/bin/env elixir

defmodule PWC do
  def eval(str) do
    {result, _} = Code.eval_string(str)
    result
  end

  def magic_expression(found, op, target, digits, ops, pos) do
    ops = List.replace_at(ops, pos, op)
    str = Enum.zip(digits, ops++[""])
    |> Enum.flat_map(fn t -> Tuple.to_list(t) end)
    |> Enum.join
    found = cond do
      !Regex.run(~r/\D0\d+/,str) && target == eval(str) ->
        Map.put(found, str, 1)
      true ->
        found
    end
    magic_expression(target, digits, ops, pos+1, found)
  end

  def magic_expression(_, _, ops, pos, found)
    when pos >= length(ops), do: found

  def magic_expression(target, digits, ops, pos, found) do
    magic_expression(found, "", target, digits, ops, pos)
    |> magic_expression("+", target, digits, ops, pos)
    |> magic_expression("-", target, digits, ops, pos)
    |> magic_expression("*", target, digits, ops, pos)
  end

  def magic_expression(target, str) do
    magic_expression(
      target,
      String.codepoints(str),
      List.duplicate("", String.length(str)-1),
      0,  # pos
      %{} # found
    )
    |> Map.keys
  end

  def solution(str, target) do
    IO.puts("Input: mystr = \"#{str}\", $target = #{target}")
    output = magic_expression(target, str)
    |> Enum.map(fn s -> "\"#{s}\"" end)
    |> Enum.join(", ")
    IO.puts("Output: (#{output})")
  end
end

IO.puts("Example 1:")
PWC.solution("123", 6)

IO.puts("\nExample 2:")
PWC.solution("105", 5)

IO.puts("\nExample 3:")
PWC.solution("232", 8)

IO.puts("\nExample 4:")
PWC.solution("1234", 10)

IO.puts("\nExample 5:")
PWC.solution("1001", 2)
