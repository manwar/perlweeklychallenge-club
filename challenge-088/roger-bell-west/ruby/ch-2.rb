#! /usr/bin/ruby

def sm(*m)
  mx=m.length
  my=m[0].length
  o=[m[0][0]]
  v=Array.new;
  1.upto(mx) do
    v.push([false] * my)
  end
  dir=[
    [0,1],
    [1,0],
    [0,-1],
    [-1,0]
  ]
  x=0
  y=0
  d=0
  2.upto(mx*my) do
    v[x][y]=true
    nx=0
    ny=0
    while (true) do
      nx=x+dir[d][0]
      ny=y+dir[d][1]
      if (nx < 0 or nx >= mx or ny < 0 or ny >= my or v[nx][ny]==true)
        d=(d+1)%4
      else
        break
      end
    end
    x=nx
    y=ny
    o.push(m[x][y])
  end
  return o
end


require 'test/unit'

class TestSm < Test::Unit::TestCase

  def test_ex1
    assert_equal(
      [1, 2, 3, 6, 9, 8, 7, 4, 5],
      sm(
  [ 1, 2, 3 ],
  [ 4, 5, 6 ],
  [ 7, 8, 9 ]
      ),
    )
  end

  def test_ex2
    assert_equal(
      [1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10],
      sm(
  [  1,  2,  3,  4 ],
  [  5,  6,  7,  8 ],
  [  9, 10, 11, 12 ],
  [ 13, 14, 15, 16 ]
      ),
    )
  end

end
