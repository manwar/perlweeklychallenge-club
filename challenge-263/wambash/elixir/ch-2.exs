defmodule Items do
  def merge(items1,items2) do
    [items1,items2]
    |> Enum.flat_map(& &1)
    |> Enum.group_by( fn [k,_] -> k end, fn [_,v] -> v end)
    |> Enum.map( fn {k,v} -> [k,  Enum.sum(v)] end)
  end
end

ExUnit.start()

defmodule ItemsTest do
  use ExUnit.Case
  test "Merge" do
    assert Items.merge([ [1,1], [2,1], [3,2] ], [ [2,2], [1,3] ]) == [ [1,4], [2,3], [3,2] ]
    assert Items.merge([ [1,2], [2,3], [1,3], [3,2] ], [ [3,1], [1,3] ]) == [ [1,8], [2,3], [3,3] ]
    assert Items.merge([ [1,1], [2,2], [3,3] ], [ [2,3], [2,4] ]) == [ [1,1], [2,9], [3,3] ]
  end
end
