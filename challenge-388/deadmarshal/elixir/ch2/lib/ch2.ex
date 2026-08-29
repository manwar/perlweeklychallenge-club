defmodule Ch2 do
  def derange(n) do
    Memo.BaseCache.start_link([])
    Memo.memoize(__MODULE__, :derange_helper, [n], cache: Memo.BaseCache)
  end

  def derange_helper(0), do: 1

  def derange_helper(n) do
    n * derange_helper(n - 1) + if rem(n, 2) == 0, do: 1, else: -1
  end
end
