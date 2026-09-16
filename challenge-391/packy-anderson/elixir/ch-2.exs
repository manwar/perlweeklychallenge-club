#!/usr/bin/env elixir

defmodule PWC do
  def box_smaller(a, b), do:
    Enum.at(a,0) < Enum.at(b,0) and Enum.at(a,1) < Enum.at(b,1)

  def arrange_boxes([], box_stack), do:
    { length(box_stack), box_stack }

  def arrange_boxes([next | rest], box_stack) do
    box = List.last(box_stack)
    if box_smaller(box, next) do
      arrange_boxes(rest, box_stack ++ [next])
    else
      arrange_boxes(rest, box_stack)
    end
  end

  def arrange_boxes(boxes) do
    boxes = Enum.sort(boxes, &(
      Enum.at(&1, 0) < Enum.at(&2, 0) or
      Enum.at(&1, 1) < Enum.at(&2, 1)
    ))
    {box, boxes} = {hd(boxes), tl(boxes)}
    arrange_boxes(boxes, [box])
  end

  def box_size(box) do
    "[#{Enum.at(box,0)}, #{Enum.at(box,1)}]"
  end

  def solution(boxes) do
    boxlist = boxes |> Enum.map(&(box_size(&1))) |> Enum.join(", ")
    IO.puts("Input: @boxes = (#{boxlist})")
    {output, box_stack} = arrange_boxes(boxes)
    boxlist = box_stack |> Enum.map(&(box_size(&1))) |> Enum.join(", ")
    IO.puts("Output: #{output}\n\n#{boxlist}")
  end
end

IO.puts("Example 1:")
PWC.solution([[1, 3], [3, 5], [6, 8], [2, 4]])

IO.puts("\nExample 2:")
PWC.solution([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]])

IO.puts("\nExample 3:")
PWC.solution([[5, 5], [5, 5], [5, 5]])

IO.puts("\nExample 4:")
PWC.solution([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]])

IO.puts("\nExample 5:")
PWC.solution([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]])
