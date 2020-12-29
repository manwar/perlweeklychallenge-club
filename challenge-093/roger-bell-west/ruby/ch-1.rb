#! /usr/bin/ruby

def mp(*cx)
  epsilon=0.0001
  mxp=0
  0.upto(cx.length-3) do |a|
    (a+1).upto(cx.length-2) do |b|
      d=0.upto(1).map {|i| cx[b][i]-cx[a][i]}
      pil=2
      (b+1).upto(cx.length-1) do |c|
        tp=false
        v=0.upto(1).map {|i| cx[c][i]-cx[a][i]}
        if d[0]==0 then
          if v[0]==0 then
            tp=true
          end
        elsif d[1]==0 then
          if v[1]==0 then
            tp=true
          end
        elsif (v[0]/d[0]-v[1]/d[1]).abs < epsilon then
          tp=true
        end
        if tp then
          pil += 1
        end
      end
      if pil > mxp then
        mxp=pil
      end
    end
  end
  return mxp
end

require 'test/unit'

class TestMp < Test::Unit::TestCase

  def test_ex1
    assert_equal(3,mp([1,1], [2,2], [3,3]))
  end

  def test_ex2
    assert_equal(3,mp([1,1], [2,2], [3,1], [1,3], [5,3]))
  end

end
