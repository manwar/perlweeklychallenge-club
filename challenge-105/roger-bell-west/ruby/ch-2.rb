#! /usr/bin/ruby

def ng(name)
  tail=name.sub(/^[bcdfghjklmnpqrstvwxz]*/i,"")
  if name == tail then
    tail=tail.downcase
  end
  return "#{name}, #{name}, bo-b#{tail}\nBonana-fanna fo-f#{tail}\nFee fi mo-m#{tail}\n#{name}!"
end

require 'test/unit'

class TestNg < Test::Unit::TestCase

  def test_ex1
    assert_equal("Katie, Katie, bo-batie\nBonana-fanna fo-fatie\nFee fi mo-matie\nKatie!",ng('Katie'))
  end

  def test_ex2
    assert_equal("Anna, Anna, bo-banna\nBonana-fanna fo-fanna\nFee fi mo-manna\nAnna!",ng('Anna'))
  end

end
