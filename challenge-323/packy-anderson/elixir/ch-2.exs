#!/usr/bin/env elixir

defmodule PWC do
  defp fmt(num) do
    cond do
      num == 0 ->
        0 # don't format a zero value
      true ->
        :erlang.float_to_binary(num, [decimals: 2])
    end
  end

  defp plusJoin(arr), do:
    Enum.join(arr, " + ")

  def taxAmt([], _, _, operations, subtotals, total) do
    # there's no more brackets, return the summary
    {
      total,
      "Total Tax => #{plusJoin(operations)}\n" <>
      "          => #{plusJoin(subtotals)}\n" <>
      "          => #{fmt(total)}"
    }
  end

  def taxAmt(_, income, _, operations, subtotals, total)
    when income == 0 do
    # there's no more income to tax, skip to the end
    taxAmt([], 0, 0, operations, subtotals, total)
  end

  def taxAmt([tax | remaining], income, last_max, operations,
             subtotals, total) do
    # the maximum amount to tax at this rate is the first
    # element of the tax bracket; but we need to adjust this
    # amount to be relative to the amount of last bracket
    max  = List.first(tax) - last_max
    # the tax rate is the second element of the bracket
    rate = List.last(tax)
    # the amount to be taxed at this rate
    amt = min(income, max)
    # calculate the tax
    tax = amt * rate/100

    taxAmt(
      remaining,
      # we've just taxed amt, so remove it from income
      income - amt,
      # adjust the last rate for the next loop
      max + last_max,
      # save the steps so we can display them at the end
      operations ++ ["(#{amt} * #{rate}/100)"],
      # make sure we display to 100ths place
      # if we hace a non-zero tax amount
      subtotals  ++ ["#{fmt(tax)}"],
      total + tax
    )
  end

  def taxAmt(income, tax) do
    if income == 0 do
      { 0, "" } # special case
    else
      taxAmt(tax, income, 0, [], [], 0)
    end
  end

  defp fmtArray(t, arr) do
    arr = arr ++ [ "[#{List.first(t)},#{List.last(t)}]" ]
    { t, arr }
  end

  def solution(income, tax) do
    {_, brackets} = Enum.map_reduce(tax, [], &fmtArray/2)
    display = Enum.join(brackets, ", ")
    IO.puts("Input: $income = #{income}, @tax = (#{display})")
    {total, explain} = taxAmt(income, tax)
    IO.puts("Output: #{total}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution(10, [[3, 50], [7, 10], [12,25]])

IO.puts("\nExample 2:")
PWC.solution(2, [[1, 0], [4, 25], [5,50]])

IO.puts("\nExample 3:")
PWC.solution(0, [[2, 50],])
