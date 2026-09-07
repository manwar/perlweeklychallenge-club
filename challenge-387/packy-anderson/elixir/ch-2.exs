#!/usr/bin/env elixir

defmodule PWC do
  @has_parens ~r/(\([^\(\)]+\)\d+)/

  def normalize_atoms(str, multiplier \\ 1) do
    multiplier = if is_integer(multiplier),
      do: multiplier, else: String.to_integer(multiplier)
    atoms = Regex.scan(~r/([A-Z][a-z]?)(\d*)/, str)
    |> Enum.reduce(%{}, fn [_, k, v], atoms ->
      v = if v == "", do: 1, else: String.to_integer(v)
      Map.put(atoms, k, Map.get(atoms, k, 0) + v * multiplier)
    end)
    sorted = Map.keys(atoms) |> Enum.sort
    Enum.reduce(sorted, "", fn k, output ->
      v = Map.get(atoms, k)
      output <> if v == 1, do: k, else: k <> Integer.to_string(v)
    end)
  end

  def atoms_count(formula) do
    formula = if Regex.match?(@has_parens, formula) do
      [match] = Regex.run(@has_parens, formula, capture: :first)
      [str, count] = Regex.run(~r/\((.+)\)(\d+)/, match,
        capture: :all_but_first)
      str = normalize_atoms(str, count) # count atoms in string
      atoms_count(String.replace(formula, match, str))
    else
      formula
    end
    normalize_atoms(formula)
  end

  def solution(formula) do
    IO.puts("Input: $formula = \"#{formula}\"")
    IO.puts("Output: \"#{atoms_count(formula)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("((N2O)3(H2O)2)2")

IO.puts("\nExample 2:")
PWC.solution("Mg3(PO4)2")

IO.puts("\nExample 3:")
PWC.solution("(((H)2)3)4")

IO.puts("\nExample 4:")
PWC.solution("NaCl3(O2(S10)2)2Mg")

IO.puts("\nExample 5:")
PWC.solution("Z2Y3(X2W)2")
