defmodule LuckyNumber do
  def lucky_number(matrix) do
    mm = min_max(matrix)
    if mm == max_min(matrix), do: mm, else: -1
  end

  def min_max(matrix) do
    matrix
    |> Stream.map(&Enum.min/1)
    |> Enum.max()
  end

  def max_min(matrix) do
    matrix
    |> Stream.zip_with(&Enum.max/1)
    |> Enum.min()
  end
end

ExUnit.start()

defmodule LuckyNumbersTest do
  use ExUnit.Case

  test "matrix 3x3" do
    matrix = [
      [3, 7, 8],
      [9, 11, 13],
      [15, 16, 17]
    ]

    assert LuckyNumber.min_max(matrix) == 15
    assert LuckyNumber.max_min(matrix) == 15
    assert LuckyNumber.lucky_number(matrix) == 15
  end

  test "matrix 4x4" do
    matrix = [
      [ 1, 10,  4,  2],
      [ 9,  3,  8,  7],
      [15, 16, 17, 12]
    ]

    assert LuckyNumber.min_max(matrix) == 12
    assert LuckyNumber.max_min(matrix) == 12
    assert LuckyNumber.lucky_number(matrix) == 12
  end

  test "matrix 2x2" do
    matrix = [
      [7, 8],
      [1, 2]
    ]

    assert LuckyNumber.min_max(matrix) == 7
    assert LuckyNumber.max_min(matrix) == 7
    assert LuckyNumber.lucky_number(matrix) == 7
  end

  test "matrix 2x2 withou lucky number" do
    matrix = [
      [7, 2],
      [1, 4]
    ]

    assert LuckyNumber.min_max(matrix) == 2
    assert LuckyNumber.max_min(matrix) == 4
    assert LuckyNumber.lucky_number(matrix) == -1
  end
end
