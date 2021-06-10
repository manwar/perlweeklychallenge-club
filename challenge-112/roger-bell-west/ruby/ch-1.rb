#! /usr/bin/ruby

def cp(i)
  p=i.split('/').find_all {|i| i != '' && i != '.'}
  d=true
  while d
    d=false
    1.upto(p.length-1) do |pi|
      if p[pi] == '..' then
        p=p[0..pi-2]+p[pi+1..-1]
        d=true
        break
      end
    end
  end
  return '/'+p.join('/')
end
      
require 'test/unit'

class TestCp < Test::Unit::TestCase

  def test_ex1
    assert_equal('/a',cp('/a/'))
  end
  
  def test_ex2
    assert_equal('/a/b/c',cp('/a/b//c/'))
  end
  
  def test_ex3
    assert_equal('/a',cp('/a/b/c/../..'))
  end
  
  def test_ex4
    assert_equal('/a/b',cp('/a/./b'))
  end
  
end
