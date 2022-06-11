#! /usr/bin/ruby

require 'test/unit'

def cardano(ct)
  out=[]
  k=0
  cn=0
  while true do
    a=3*k+2
    b2c=(k+1)*(k+1)*(8*k+5)
    b=0
    b2=0
    inc=1
    while true do
      b += 1
      b2 += inc
      inc += 2
      if b2 > b2c then
        break
      end
      if b2c % b2 == 0 then
        out.push([a,b,b2c/b2])
        cn += 1
        if cn >= ct then
          break
        end
      end
    end
    if cn >= ct then
      break
    end
    k += 1
  end
  return out
end

class TestCardano < Test::Unit::TestCase

  def test_ex1
    assert_equal([[2,1,5],
                  [5,1,52],
                  [5,2,13],
                  [8,1,189],
                  [8,3,21]],cardano(5))
  end

end
