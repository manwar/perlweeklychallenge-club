#! /usr/bin/ruby

require 'set'

def secretsanta(name)
  family = []
  name.each do |n|
    family.push(n.split(' ')[-1])
  end
  receivers = Set.new(Array.new(name.length) {|i| i})
  gifting = []
  0.upto(name.length - 1) do |giver|
    done = false
    r = 0
    receivers.each do |recipient|
      if family[giver] != family[recipient] then
        r = recipient
        done = true
        break
      end
    end
    if !done then
      receivers.each do |recipient|
        if giver != recipient then
          r = recipient
          break
        end
      end
    end
    receivers.delete(r)
    gifting.push([name[giver], name[r]])
  end
  gifting.each do |p|
    print("#{p[0]} -> #{p[1]}\n")
  end
  print("\n")
  return true
end

require 'test/unit'

class TestSecretsanta < Test::Unit::TestCase

  def test_ex1
    assert_equal(true, secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross']))
  end

  def test_ex2
    assert_equal(true, secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar']))
  end

end
