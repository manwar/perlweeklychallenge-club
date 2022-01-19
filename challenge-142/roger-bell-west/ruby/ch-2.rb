#! /usr/bin/ruby

def sleepsort(n)
  mutex=Mutex.new
  r=[]
  threads=n.collect do |x|
    Thread.new do
      sleep(0.001 * x)
      mutex.synchronize {r.push(x)}
    end
  end
  threads.each { |t| t.join }
  return r
end

require 'test/unit'

class TestSleepsort < Test::Unit::TestCase

  def test_ex1
    r=Random.new
    a=1.upto(10).map{rand(100)}
    assert_equal(a.sort(),sleepsort(a))
  end

end
