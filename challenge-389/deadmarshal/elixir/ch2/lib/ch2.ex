defmodule Ch2 do
  @spec zig_zag_subarray(list(integer)) :: non_neg_integer
  def zig_zag_subarray([]), do: 0
  def zig_zag_subarray([_]), do: 1
  def zig_zag_subarray([h|t]) do
    {_,_,_,max} = List.foldl(t,{h,1,1,1},fn x,{prev,up,down,max} ->
      cond do
	x > prev -> {x,down+1,1,max(max,down+1)}
	x < prev -> {x,1,up+1,max(max,up+1)}
	true -> {x,1,1,max}
      end
    end)
    max
  end
end

