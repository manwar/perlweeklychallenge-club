defmodule Ch1 do
  @spec longest_parenthesis(s :: String.t()) :: integer
  def longest_parenthesis(s) do
    s
    |> String.graphemes()
    |> dp([], 0)
  end

  defp dp([], _, result), do: result

  defp dp(["(" | tail], stack, result) do
    dp(tail, [0 | stack], result)
  end

  defp dp([")" | tail], stack, result) do
    {new_stack, new_result} = pop_until(stack, [])

    dp(tail, new_stack, max(result, new_result))
  end

  defp pop_until([], _), do: {[], 0}

  defp pop_until([0 | tail], rest) do
    n = List.first(tail)
    n = if n, do: n, else: 0
    tail = if n > 0, do: tl(tail), else: tail
    result = Enum.sum(rest) + n + 2
    
    {[result | tail], result}
  end

  defp pop_until([h | tail], rest) do
    pop_until(tail, [h | rest])
  end
end

