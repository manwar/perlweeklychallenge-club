defmodule Matrix do
 def weekest_row(matrix) do
    matrix
    |> Enum.with_index
    |> Enum.sort
    |> Enum.map( fn {_,index} -> index end)
  end
end

ExUnit.start()

defmodule MatrixTest do
  use ExUnit.Case
  test "Matrix" do
    matrix = [
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ]
    assert Matrix.weekest_row(matrix) ==  [2,0,3,1,4]

  end
  test "Matrix same rows" do
    matrix = [
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0],
                 ]
    assert Matrix.weekest_row(matrix) ==  [0,2,3,1]

  end
end
