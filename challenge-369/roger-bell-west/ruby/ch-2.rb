#! /usr/bin/ruby

def groupdivision(a0, sz, pad)
  a = a0
  while a.size % sz != 0 do
    a += pad
  end
  out = []
  i = 0
  while i < a.size do
    out.append(a.slice(i, sz))
    i += sz
  end
  out
end

require 'test/unit'

class TestGroupdivision < Test::Unit::TestCase

  def test_ex1
    assert_equal(['Raku', 'Perl'], groupdivision('RakuPerl', 4, '*'))
  end

  def test_ex2
    assert_equal(['Pytho', 'n0000'], groupdivision('Python', 5, '0'))
  end

  def test_ex3
    assert_equal(['123', '45x'], groupdivision('12345', 3, 'x'))
  end

  def test_ex4
    assert_equal(['Hel', 'loW', 'orl', 'd__'], groupdivision('HelloWorld', 3, '_'))
  end

  def test_ex5
    assert_equal(['AI!!!'], groupdivision('AI', 5, '!'))
  end

end
