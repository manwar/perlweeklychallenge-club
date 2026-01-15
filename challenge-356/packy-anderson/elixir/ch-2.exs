#!/usr/bin/env elixir

defmodule PWC do
  import Enum,   only: [find: 2, sort: 1, zip_with: 2]
  import List,   only: [pop_at: 2, to_tuple: 1]
  import String, only: [graphemes: 1, slice: 2]
  import Tuple,  only: [to_list: 1]

  def who_wins_tuples(results, tuples) do
    results = graphemes(results)
    zip_with([results, tuples], fn [result, { home, away }] ->
      if result == "H" do home else away end
    end) |> sort
  end

  def who_wins(results) do
    # week 1
    winners = who_wins_tuples(
      slice(results, 0..2),
      [ {2,7}, {3,6}, {4,5} ]
    )
    results = slice(results, 3..6) # remove the first 3 results
    {lowest, winners} = pop_at(winners, -1)

    # week 2
    winners = who_wins_tuples(
      slice(results, 0..1),
      [ {1, lowest}, to_tuple(winners) ]
    )
    results = slice(results, 2..2) # remove the next 2 results

    # week 3
    tuples  = [ to_tuple(winners) ]
    winners = who_wins_tuples(results, tuples)

    win  = hd(winners)
    loss = hd(tuples) |> to_list |> find(fn x -> x != win end)

    "Team #{win} defeated Team #{loss}"
  end

  def solution(results) do
    IO.puts("Input: $results = \"#{results}\"")
    IO.puts("Output: " <> who_wins(results))
  end
end

IO.puts("Example 1:")
PWC.solution("HAHAHH")

IO.puts("\nExample 2:")
PWC.solution("HHHHHH")

IO.puts("\nExample 3:")
PWC.solution("HHHAHA")

IO.puts("\nExample 4:")
PWC.solution("HAHAAH")

IO.puts("\nExample 5:")
PWC.solution("HAAHAA")
