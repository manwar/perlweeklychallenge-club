#!/usr/bin/env elixir

defmodule PWC do
  require Integer # because is_odd is a guard

  def display_two(display1, display2) do
    Enum.zip_with(
      String.split(display1, "\n"),
      String.split(display2, "\n"),
      fn x, y -> x <> y end
    )
    |> Enum.join("\n")
  end

  def display_matrix(label, matrix) do
    rows = for row <- matrix, do:
      "[ " <> Enum.join(row, " ") <> " ]  "
    width = (length(Enum.at(matrix, 0)) + 2) * 2 + 1
    Enum.join(
      [ String.pad_trailing(label, width) ] ++ rows, "\n"
    ) <> "\n"
  end

  def empty_matrix(row, col) do
    for _r <- 1..row do
      for _c <- 1..col, do: 0
    end
  end

  def increment_row(row, matrix) do
    List.replace_at(matrix, row,
      (for elem <- Enum.at(matrix, row), do: elem + 1)
    )
  end

  def increment_col(col, matrix) do
    for row <- matrix, do:
      List.replace_at(row, col, Enum.at(row, col) + 1)
  end

  def count_odd(matrix) do
    {_, count} = Enum.map_reduce(matrix, 0, fn row, count ->
      {_, count} = Enum.map_reduce(row, count, fn elem, count ->
        {
          elem,
          cond do
            Integer.is_odd(elem) -> count + 1
            true -> count
          end
        }
      end)
      { row, count }
    end)
    count
  end

  def odd_matrix([], matrix, display) do
    {
      count_odd(matrix),
      display <> "\n" <> display_matrix("Final:", matrix)
    }
  end

  def odd_matrix([loc | locs], matrix, display) do
    {row, col} = {List.first(loc), List.last(loc)}
    display = display <> "\nApply [#{row},#{col}]:\n"
    display = display <> "Increment row #{row}:\n"
    before_var = display_matrix("Before", matrix)
    matrix = increment_row(row, matrix)
    after_var = display_matrix("After", matrix)
    display = display <> display_two(before_var, after_var)

    display = display <> "Increment col #{col}:\n"
    before_var = display_matrix("Before", matrix)
    matrix = increment_col(col, matrix)
    after_var = display_matrix("After", matrix)
    display = display <> display_two(before_var, after_var)

    odd_matrix(locs, matrix, display)
  end

  def odd_matrix(row, col, locations) do
    matrix = empty_matrix(row, col)
    odd_matrix(
      locations, matrix,
      display_matrix("Initial:", matrix)
    )
  end

  def solution(row, col, locations) do
    loc_list = locations
    |> Enum.map(fn l -> "(" <> Enum.join(l,",") <> ")" end)
    |> Enum.join(",")
    IO.puts(
      "Input: $row = #{row}, $col = #{col}, " <>
      "@locations = (#{loc_list})"
    )
    {odd, explain} = odd_matrix(row, col, locations)
    IO.puts("Output: #{odd}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution(2, 3, [[0,1],[1,1]])

IO.puts("\nExample 2:")
PWC.solution(2, 2, [[1,1],[0,0]])

IO.puts("\nExample 3:")
PWC.solution(3, 3, [[0,0],[1,2],[2,1]])

IO.puts("\nExample 4:")
PWC.solution(1, 5, [[0,2],[0,4]])

IO.puts("\nExample 5:")
PWC.solution(4, 2, [[1,0],[3,1],[2,0],[0,1]])
