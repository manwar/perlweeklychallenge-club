#! /usr/bin/ruby

def hj(a,b,c,d)
  h=[a,c]
  i=[b,d]
  m=Hash.new
  0.upto(1) do |x|
    j=1-i[x]
    0.upto(h[x].length-1) do |y|
      unless m.has_key?(h[x][y][i[x]]) then
        m[h[x][y][i[x]]]=[[],[]]
      end
      m[h[x][y][i[x]]][x].push(h[x][y][j])
    end
  end
  o=[]
  for k in m.sort_by {|kx, vx| kx}
    for a in k[1][0]
      for b in k[1][1]
        o.push([a,k[0],b])
      end
    end
  end
  return o
end

require 'test/unit'

class TestHj < Test::Unit::TestCase

  def test_ex1
    assert_equal(hj(
                   [
                     [20, "Alex" ],
                     [28, "Joe" ],
                     [38, "Mike" ],
                     [18, "Alex" ],
                     [25, "David" ],
                     [18, "Simon" ],
                   ],
                   1,
                   [
                     ["Alex", "Stewart"],
                     ["Joe", "Root" ],
                     ["Mike", "Gatting"],
                     ["Joe", "Blog" ],
                     ["Alex", "Jones" ],
                     ["Simon","Duane" ],
                   ],
                   0
                 ),[
                   [ 20, "Alex", "Stewart"],
                   [ 20, "Alex", "Jones"],
                   [ 18, "Alex", "Stewart"],
                   [ 18, "Alex", "Jones"],
                   [ 28, "Joe", "Root" ],
                   [ 28, "Joe", "Blog"],
                   [ 38, "Mike", "Gatting"],
                   [ 18, "Simon", "Duane"]
                 ]
                )
  end
  
end
