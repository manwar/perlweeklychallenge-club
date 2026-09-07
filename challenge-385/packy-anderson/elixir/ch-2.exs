#!/usr/bin/env elixir

defmodule PWC do
  def find_primitives(str, _, _, primitives) when str == "",
    do: primitives

  def find_primitives(str, prim, count, primitives) do
    char = String.slice(str, 0, 1)   # first char
    str  = String.slice(str, 1, 100) # remaining string
    prim = prim <> char       # append char to current primative

    {prim, count, primitives} = cond do
      char == ")" and count == 1 ->
        {
          "",                  # clear current primative
          0,                   # clear paren count
          primitives ++ [prim] # add to primative list
        }
      char == ")" and count > 1 ->
        # decrease paren count
        {prim, count - 1, primitives}
      true ->
        # increase paren count
        {prim, count + 1, primitives}
    end

    # recursively call to process rest of string
    find_primitives(str, prim, count, primitives)
  end

  def outermost_parentheses(str) do
    primitives = find_primitives(str, "", 0, [])
    {
      primitives
      |> Enum.map(&( String.slice(&1, 1, String.length(&1)-2) ))
      |> Enum.join,
      primitives
    }
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(" + ")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    {output, primitives} = outermost_parentheses(str)
    IO.puts("Output: \"#{output}\"\n")
    IO.puts("Primitive Decomposition: #{quote_join(primitives)}")
  end
end

IO.puts("Example 1:")
PWC.solution("()()()")

IO.puts("\nExample 2:")
PWC.solution("(((())))")

IO.puts("\nExample 3:")
PWC.solution("(()())(())")

IO.puts("\nExample 4:")
PWC.solution("()((()))()")

IO.puts("\nExample 5:")
PWC.solution("(()(()))(()())")
