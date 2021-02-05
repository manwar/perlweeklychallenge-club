#! /usr/bin/ruby

$rn=Hash.new

def readN(fn,siz)
  if $rn.has_key?(fn) then
    fh=$rn[fn]
  else
    fh=File.new(fn,'r')
    $rn[fn]=fh
  end
  buf=fh.read(siz)
  if fh.eof? then
    fh.close
    $rn.delete(fn)
  end
  return buf
end

require 'test/unit'

class TestCc < Test::Unit::TestCase

  def test_ex1
    assert_equal('1234',readN('input.txt',4))
  end

  def test_ex2
    assert_equal('5678',readN('input.txt',4))
  end

  def test_ex3
    assert_equal('90',readN('input.txt',4))
  end

end
