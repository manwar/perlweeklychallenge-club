#!/usr/bin/env elixir

defmodule PWC do
  defp pad(num) do
    String.pad_leading(to_string(num), 2)
  end

  defp wrap(num) do
    if num < 0 do
      "(#{num})"
    else
      "#{num}"
    end
  end

  def final_score([], stack, rounds, _) do
    total = Enum.sum(stack)
    { total, rounds <> "\nTotal Scores: #{total}" }
  end

  def final_score([action | scores], stack, rounds, count) do
    previous = List.last(stack)
    stack = case action do
      "+" ->
        {a, b} = {Enum.at(stack, -1), Enum.at(stack, -2)}
        List.insert_at(stack, -1, a + b)
      "C" ->
        List.delete_at(stack, -1)
      "D" ->
        List.insert_at(stack, -1, Enum.at(stack, -1) * 2)
      _   ->
        List.insert_at(stack, -1, String.to_integer(action) )
    end
    rounds = rounds
      <> "Round #{pad(count)}: "
      <> Enum.join(Enum.map(stack, &wrap/1), " + ")
      <> case action do
        "+" -> " (sum of previous two scores)"
        "C" -> " (invalidate the previous score #{previous})"
        "D" -> " (double the previous score #{previous})"
        _   -> ""
      end
      <> "\n"
    final_score(scores, stack, rounds, count+1)
  end

  def final_score(scores) do
    final_score(scores, [], "", 1)
  end

  def solution(scores) do
    score_list = scores
    |> Enum.map(fn n -> "\"#{n}\"" end)
    |> Enum.join(", ")
    IO.puts("Input: @ints = (#{score_list})")
    {output, rounds} = final_score(scores)
    IO.puts("Output: #{output}\n\n#{rounds}")
  end
end

IO.puts("Example 1:")
PWC.solution(["5","2","C","D","+"])

IO.puts("\nExample 2:")
PWC.solution(["5","-2","4","C","D","9","+","+"])

IO.puts("\nExample 3:")
PWC.solution(["7","D","D","C","+","3"])

IO.puts("\nExample 4:")
PWC.solution(["-5","-10","+","D","C","+"])

IO.puts("\nExample 5:")
PWC.solution(["3","6","+","D","C","8","+","D","-2","C","+"])
