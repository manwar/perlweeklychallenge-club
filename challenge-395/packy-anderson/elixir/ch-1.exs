#!/usr/bin/env elixir

defmodule PWC do
  def parse_complex(c) do
    integer = "[+-]? \\d+ | \\( \\s* [+-]? \\d+ \\s* \\)"
    parse = Regex.compile!(
      "(?<real>" <> integer <> ")"  <>
      "\\s* (?<op>[+-]) \\s*" <>
      "(?<imag>" <> integer <> ") \\s* i", "x"
    )
    m = Regex.named_captures(parse, c)
    if m do
      strip_parens = fn name ->
        Regex.replace(~r/[()]/, Map.get(m, name), "")
        |> String.to_integer
      end
      real = strip_parens.("real")
      imag = strip_parens.("imag")
      imag = if Map.get(m, "op") == "-", do: -1 * imag,
             else: imag
      {real, imag}
    end
  end

  def complex_mult(num1, num2) do
    {a, b} = parse_complex(num1)
    {c, d} = parse_complex(num2)
    e = (a * c) - (b * d)
    f = (a * d) + (b * c)
    f = if f < 0, do: "(#{f})", else: f
    "#{e}+#{f}i"
  end

  def solution(num1, num2) do
    IO.puts("Input: $num1 = \"#{num1}\", $num2 = \"#{num2}\"")
    IO.puts("Output: \"#{complex_mult(num1, num2)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("1+1i", "1+1i")

IO.puts("\nExample 2:")
PWC.solution("1+(-1)i", "1+(-1)i")

IO.puts("\nExample 3:")
PWC.solution("0+3i", "0+4i")

IO.puts("\nExample 4:")
PWC.solution("3+4i", "3+(-4)i")

IO.puts("\nExample 5:")
PWC.solution("50+(-20)i", "-10+30i")

IO.puts("\nExample 6:")
PWC.solution("-2+5i", "5-5i")
