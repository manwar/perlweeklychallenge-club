defmodule Strings do
  def split(words, separator \\ " ") do
    words |> Enum.flat_map(&String.split(&1,separator,trim: true))
  end
end


ExUnit.start()

defmodule StringsTest do
  use ExUnit.Case

  test "Split strings" do
    assert Strings.split(["one.two.three","four.five","six"],".") == ["one","two","three","four","five","six"]
  end
  test "Split strings need trim" do
    assert Strings.split(["$perl$$", "$$raku$"],"$") == ["perl","raku"]
  end
end
