defmodule Ch2Test do
  use ExUnit.Case, async: true
  
  describe "zig_zag_subarray/1" do
    test_cases = [
      {1,[9,4,2,10,7,8,8,1,9],5},
      {2,[1,7,4,9,2,5],6},
      {3,[1,2,3,4,5],2},
      {4,[4,4,4],1},
      {5,[10,20,15,12,18],3},
    ]

    for {n, l, expected} <- test_cases do
      test "Example: #{n}" do
        assert Ch2.zig_zag_subarray(unquote(l)) == unquote(expected)
      end
    end
  end
end

