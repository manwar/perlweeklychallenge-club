defmodule Ch1 do
  def dyck_words(0), do: [""]

  def dyck_words(n) do
    dyck_words(n, 0, 0, [])
    |> Enum.sort()
  end

  defp dyck_words(n, n, n, acc) do
    [acc |> Enum.reverse() |> List.to_string()]
  end

  defp dyck_words(n, open, close, acc) do
    open_results =
      if open < n do
        dyck_words(n, open + 1, close, [?U | acc])
      else
        []
      end

    close_results =
      if close < n and open > close do
        dyck_words(n, open, close + 1, [?D | acc])
      else
        []
      end

    open_results ++ close_results
  end
end
