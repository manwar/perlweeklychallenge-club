defmodule Target do
 def index(ints, [k: k]) do
    ints 
    |> Enum.sort
    |> Stream.with_index
    |> Stream.drop_while(fn {v,_} -> v <  k end)
    |> Stream.take_while(fn {v,_} -> v <= k end)
    |> Stream.map( fn {_,i} -> i end )
    |> Enum.to_list
  end
end

ExUnit.start()

defmodule TargetTest do
  use ExUnit.Case
  test "Target" do
    assert Target.index([1, 5, 3, 2, 4, 2], k: 2) == [1,2]
    assert Target.index([1, 2, 4, 3, 5],    k: 6) == []
    assert Target.index([5, 3, 2, 4, 2, 1], k: 4) == [4]
  end
end
