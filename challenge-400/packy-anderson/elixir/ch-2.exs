#!/usr/bin/env elixir

defmodule PWC do
  def mutations(gene1, gene2) do
    str_to_map = fn str ->
      str
      |> String.graphemes()
      |> then(&(Enum.zip(0..length(&1), &1) |> Map.new()))
    end

    g1 = str_to_map.(gene1)
    g2 = str_to_map.(gene2)

    Enum.reduce(0..map_size(g1), 0, fn i, count ->
      if g1[i] != g2[i], do: count + 1, else: count
    end)
  end

  def minimum_genetic_mutation(start, stop, _)
      when start == stop, do: {0, []}

  def minimum_genetic_mutation(start, stop, bank) do
    if not Enum.any?(bank, &(&1 == stop)) do
      {-1, []}
    else
      branches =
        bank
        |> Enum.reduce([], fn gene, branches ->
          if mutations(start, gene) == 1 do
            {count, transitions} =
              minimum_genetic_mutation(
                gene,
                stop,
                Enum.filter(bank, &(&1 != gene))
              )

            if count >= 0 do
              branches ++
                [
                  %{
                    count: count + 1,
                    transitions:
                      ["  \"#{start}\" => \"#{gene}\""] ++
                        transitions
                  }
                ]
            else
              branches
            end
          else
            branches
          end
        end)

      if length(branches) == 0 do
        {-1, []}
      else
        branches
        |> Enum.min_by(& &1.count)
        |> then(& {&1.count, &1.transitions})
      end
    end
  end

  def quote_join(array) do
    Enum.map(array, &"\"#{&1}\"") |> Enum.join(", ")
  end

  def solution(start_gene, end_gene, gene_bank) do
    IO.puts("Input: $start_gene = \"#{start_gene}\"")
    IO.puts("       $end_gene   = \"#{end_gene}\"")
    IO.puts("       @gene_bank  = (#{quote_join(gene_bank)})")

    {count, transitions} =
      minimum_genetic_mutation(start_gene, end_gene, gene_bank)

    IO.puts("Output: #{count}")

    if count > 0 do
      IO.puts("\nTransitions:")
      transitions |> Enum.join("\n") |> IO.puts()
    end
  end
end

IO.puts("Example 1")
PWC.solution("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"])

IO.puts("\nExample 2")

PWC.solution("AACCGGTT", "AACCGGAA", [
  "AACCGGTA",
  "AACCGGAA",
  "AACCGCTA",
  "AACCCTAA",
  "AACCGTAA"
])

IO.puts("\nExample 3")

PWC.solution("AAAAAAAA", "AAAAACCC", [
  "CAAAAAAA",
  "CCAAAAAA",
  "AAAAAAAC"
])

IO.puts("\nExample 4")

PWC.solution("GAAAAAAA", "GCCCCCCC", [
  "GCAAAAAA",
  "GCCAAAAA",
  "GCCCAAAA",
  "GCCCCAAA",
  "GCCCCCAA",
  "GCCCCCCA",
  "GCCCCCCC"
])

IO.puts("\nExample 5")
PWC.solution("AACCGGTT", "AACCGGTT", ["AACCGGTA"])
