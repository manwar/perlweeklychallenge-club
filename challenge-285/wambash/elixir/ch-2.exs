defmodule Change do
  defp _making({0,_}),do: [1]
  defp _making({_,[]}),do: [0]
  defp _making({amount, [hc| coins]}) when hc > amount, do: _making({amount,coins})
  defp _making({amount, coins}) do
    coins
    |> Enum.flat_map(fn
      x -> _making(
        {
          amount - x,
          coins |> Enum.drop_while( & &1 > x )
        }
      )
    end)
  end
  def making(w) do
    _making(w) |> Enum.sum
  end
end

ExUnit.start()

defmodule ChangeTest do
  use ExUnit.Case
  test "Change" do
    assert Change.making({9,[50,25,10,5,1]})  == 2
    assert Change.making({100,[50,25,10,5,1]}) == 292
    assert Change.making({15,[50,25,10,5,1]})  == 6
  end
end
