#! /usr/bin/ruby

def fs(*s)
  t=0
  maxx=s.length-1
  maxy=s[0].length-1
  0.upto(maxx-1) do |x|
    0.upto(maxy-1) do |y|
      if s[x][y] == 1
        1.upto([maxx-x,maxy-y].min) do |d|
          if s[x+d][y] == 1 and
            s[x][y+d] == 1 and
            s[x+d][y+d] == 1
            t += 1
          end
        end
      end
    end
  end
  return t
end

#sub fs(@s) {
#  my $t=0;
#  my $maxx=@s.elems-1;;
#  my $maxy=@s[0].elems-1;
#  for (0..$maxx-1) -> $x {
#    for (0..$maxy-1) -> $y {
#      if (@s[$x][$y]==1) {
#        for (1..min($maxx-$x,$maxy-$y)) -> $d {
#          if (@s[$x+$d][$y]==1 &&
#                @s[$x][$y+$d]==1 &&
#                @s[$x+$d][$y+$d]==1
#                  ) {
#            $t++;
#          }
#        }
#      }
#    }
#  }
#  return $t;
#}

require 'test/unit'

class TestFs < Test::Unit::TestCase

  def test_ex1
    assert_equal(1,
                 fs(
                      [0,1,0,1],
                      [0,0,1,0],
                      [1,1,0,1],
                      [1,0,0,1]
                    ),
                 'example 1')
  end

  def test_ex2
    assert_equal(4,
                 fs(
                      [1,1,0,1],
                      [1,1,0,0],
                      [0,1,1,1],
                      [1,0,1,1]
                    ),
                 'example 2')
  end

  def test_ex3
    assert_equal(0,
                 fs(
                      [0,1,0,1],
                      [1,0,1,0],
                      [0,1,0,0],
                      [1,0,0,1]
                    ),
                 'example 3')
  end

end
