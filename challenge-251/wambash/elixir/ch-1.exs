defmodule Concatenation do
  def iter([]) do
    nil
  end

  def iter([o]) do
    {o, []}
  end

  def iter([f | t]) do
    with [l | t] <- Enum.reverse(t) do
      {String.to_integer("#{f}#{l}"), Enum.reverse(t)}
    end
  end

  def value(ints) do
    ints
    |> Stream.unfold(&iter/1)
    |> Enum.sum()
  end
end

ExUnit.start()

defmodule ConcatenationTest do
  use ExUnit.Case

  test "concatenation value" do
    assert Concatenation.iter([6, 12, 25, 1]) == {61, [12, 25]}
    assert Concatenation.iter([12, 25]) == {1225, []}
    assert Concatenation.iter([]) == nil
    assert Concatenation.value([6, 12, 25, 1]) == 1286
  end

  test "concatenation value more elems" do
    assert Concatenation.iter([10, 7, 31, 5, 2, 2]) == {102, [7, 31, 5, 2]}
    assert Concatenation.value([10, 7, 31, 5, 2, 2]) == 489
  end

  test "concatenation value odd elems" do
    assert Concatenation.iter([1, 2, 10]) == {110, [2]}
    assert Concatenation.iter([2]) == {2, []}
    assert Concatenation.value([1, 2, 10]) == 112
  end
end
