#! /usr/bin/ruby

def rd(tree,content)
  st=tree.length
  depth=0
  dl=1
  db=1
  0.upto(tree.length()-1) do |i|
    if tree[i] == content then
      return depth
    end
    dl -= 1
    if dl==0 then
      db *= 2
      dl=db
      depth += 1
    end
  end
  return -1
end

require 'test/unit'

class TestRd < Test::Unit::TestCase

  def test_ex1a
    assert_equal(3,rd([
                       1,
                       2,      3,
                       0,  0,  0,  4,
                       0,0,0,0,0,0,5,6
                     ],6))
  end

  def test_ex1b
    assert_equal(3,rd([
                       1,
                       2,      3,
                       0,  0,  0,  4,
                       0,0,0,0,0,0,5,6
                     ],5))
  end

  def test_ex1c
    assert_equal(1,rd([
                       1,
                       2,      3,
                       0,  0,  0,  4,
                       0,0,0,0,0,0,5,6
                     ],2))
  end

  def test_ex1d
    assert_equal(2,rd([
                       1,
                       2,      3,
                       0,  0,  0,  4,
                       0,0,0,0,0,0,5,6
                     ],4))
  end

  def test_ex2a
    assert_equal(3,rd([
                        1,
                        2,              3,
                        4,      0,      0,      5,
                        0,  6,  0,  0,  0,  0,  7,  0,
                        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
                     ],7))
  end

  def test_ex2b
    assert_equal(4,rd([
                        1,
                        2,              3,
                        4,      0,      0,      5,
                        0,  6,  0,  0,  0,  0,  7,  0,
                        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
                     ],8))
  end

  def test_ex2c
    assert_equal(3,rd([
                        1,
                        2,              3,
                        4,      0,      0,      5,
                        0,  6,  0,  0,  0,  0,  7,  0,
                        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
                     ],6))
  end
  
end
