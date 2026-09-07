defmodule Ch2Test do
  use ExUnit.Case
  doctest Ch2

  test "derange test" do
    assert Ch2.derange(1) == 0
    assert Ch2.derange(2) == 1
    assert Ch2.derange(3) == 2
    assert Ch2.derange(4) == 9
    assert Ch2.derange(5) == 44
  end
end
