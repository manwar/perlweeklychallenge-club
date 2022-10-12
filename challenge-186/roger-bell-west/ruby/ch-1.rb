#! /usr/bin/ruby

require 'test/unit'

def ziplist(a,b)
  return a.zip(b).flatten
end

class TestZiplist < Test::Unit::TestCase

  def test_ex1
    assert_equal([1, "a", 2, "b", 3, "c"],
                 ziplist([1, 2, 3], ["a", "b", "c"]))
  end

end
