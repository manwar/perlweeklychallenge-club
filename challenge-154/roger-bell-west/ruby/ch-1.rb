#! /usr/bin/ruby

require 'test/unit'

require 'set'

def missingpermutations(list)
  out=[]
  perms=Set.new
  list[0].chars.to_a.permutation do |w|
    perms.add(w.join)
  end
  list.each do |w|
    perms.delete(w)
  end
  return perms.to_a
end

class TestMissingPermutations < Test::Unit::TestCase

  def test_ex1
    assert_equal(["LERP"],missingpermutations(["PELR", "PREL", "PERL",
   "PRLE", "PLER", "PLRE", "EPRL", "EPLR", "ERPL", "ERLP", "ELPR",
   "ELRP", "RPEL", "RPLE", "REPL", "RELP", "RLPE", "RLEP", "LPER",
   "LPRE", "LEPR", "LRPE", "LREP"]))
  end

end
