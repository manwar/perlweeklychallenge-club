#! /usr/bin/ruby

require 'test/unit'

def sequencenumber(list)
  nn = 0
  out = []
  list.each do |ins|
    out.push(sprintf("%02d", nn) + ins[2..5])
    nn += 1
  end
  return out
end

class TestSequencenumber < Test::Unit::TestCase

  def test_ex1
    assert_equal(["001234", "015678", "021342"],
                 sequencenumber(["ab1234", "cd5678", "ef1342"]))
  end

  def test_ex2
    assert_equal(["001122", "013334"],
                 sequencenumber(["pq1122", "rs3334"]))
  end

end
