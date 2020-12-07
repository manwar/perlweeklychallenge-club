#! /usr/bin/ruby

def gs(bs)
  l={'A' => 'T', 'T' => 'A', 'C' => 'G', 'G' => 'C'}
  os=bs.chars.map{|i| l[i]}.join('')
  return [os.length(),os]
end

require 'test/unit'

class TestGs < Test::Unit::TestCase

  def test_ex1
    assert_equal([67,'CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC'],gs('GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'))
  end

end
