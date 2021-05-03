#! /usr/bin/ruby

def sm(matrix,search)
  f=0
  matrix.each {|row|
    if row[0] <= search then
      if row[-1] >= search then
        if row.include?(search) then
          f=1
        end
        break
      end
    else
      break
    end
  }
  return f
end

require 'test/unit'

class TestSm < Test::Unit::TestCase

  def test_ex1
    assert_equal(0,sm([[  1,  2,  3,  5,  7 ],
                       [  9, 11, 15, 19, 20 ],
                       [ 23, 24, 25, 29, 31 ],
                       [ 32, 33, 39, 40, 42 ],
                       [ 45, 47, 48, 49, 50 ]],35))
  end
  

  def test_ex2
    assert_equal(1,sm([[  1,  2,  3,  5,  7 ],
                       [  9, 11, 15, 19, 20 ],
                       [ 23, 24, 25, 29, 31 ],
                       [ 32, 33, 39, 40, 42 ],
                       [ 45, 47, 48, 49, 50 ]],39))
  end
  

end
