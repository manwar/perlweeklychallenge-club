defmodule Ch1 do

  @spec permute(list(term()),[non_neg_integer()]) :: list(term())
  def permute(l,perms) do
    Enum.zip(perms,l)
    |> Enum.sort_by(fn {perm,_value} -> perm end)
    |> Enum.map(fn {_perm,value} -> value end)
  end

  @spec reorder_notes({String.t(),
		       [String.t()],
		       [non_neg_integer()]}) :: String.t()
  def reorder_notes({composer,notes,perm}) do
    notes
    |> permute(perm)
    |> then(&(String.upcase(composer) <> " => " <> Enum.join(&1," ")))
  end
end

