#! /usr/bin/ruby

def lr(*s)
  maxx=s.length-1;
  maxy=s[0].length-1;
  maxa=0;
  c=Array.new;
  0.upto(maxx-1) do |x|
    0.upto(maxy-1) do |y|
      if (s[x][y]==1)
        (x+1).upto(maxx) do |tx|
          (y+1).upto(maxy) do |ty|
            valid=true
            x.upto(tx) do |sx|
              y.upto(ty) do |sy|
                if (s[sx][sy] != 1)
                  valid=false
                  break
                end
              end
              if valid==false
                break
              end
            end
            if valid
              l=[tx-x+1,ty-y+1]
              a=l[0]*l[1]
              if (a > maxa)
                maxa=a
                c=l
              end
            end
          end
        end
      end
    end
  end
  if (c.length > 0)
    o=Array.new
    1.upto(c[0]) do
      o.push([1] * c[1])
    end
    return o
  end
  return 0
end

require 'test/unit'

class TestLr < Test::Unit::TestCase

  def test_ex1
    assert_equal(
      [
        [1,1,1,1,1],
        [1,1,1,1,1],
      ],
      lr(
        [0,0,0,1,0,0],
        [1,1,1,0,0,0],
        [0,0,1,0,0,1],
        [1,1,1,1,1,0],
        [1,1,1,1,1,0],
      ),
    )
  end

  def test_ex2
    assert_equal(
      0,
      lr(
        [1,0,1,0,1,0],
        [0,1,0,1,0,1],
        [1,0,1,0,1,0],
        [0,1,0,1,0,1],
      ),
    )
  end

  def test_ex3
    assert_equal(
      [
        [1,1,1,1],
        [1,1,1,1],
      ],
      lr(
        [0,0,0,1,1,1],
        [1,1,1,1,1,1],
        [0,0,1,0,0,1],
        [0,0,1,1,1,1],
        [0,0,1,1,1,1],
      ),
    )
  end

end


