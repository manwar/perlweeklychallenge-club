#! /usr/bin/crystal

# from https://rosettacode.org/wiki/Cartesian_product_of_two_or_more_lists#Crystal

def cartesian_product(a, b)
    return a.flat_map { |i| b.map { |j| [i, j] } }
end

def cartesian_product(l)
    if l.size <= 1
        return l
    elsif l.size == 2
        return cartesian_product(l[0], l[1])
    end
    return l[0].flat_map { |i| 
        cartesian_product(l[1..]).map { |j|
            [i, j].flatten
        }
    }
end

def makingchange(a)
  coins = [1, 5, 10, 25, 50]
  max = coins.map { |x| (a / x).to_i }
  pat = Array(Array(Int32)).new
  0.upto(coins.size - 1) do |i|
    if max[i] > 0
      al = Array.new(max[i] + 1, 0)
      al.fill(0..) { |i| i }
      pat.push(al)
    else
      break
    end
  end
  ct = 0
  cartesian_product(pat).each do |combo|
    t = 0
    combo.each_with_index do |c, i|
      t += c * coins[i]
      if t > a
        break
      end
    end
    if t == a
      ct += 1
    end
  end
  ct
end

require "spec"
describe "makingchange" do
  it "test_ex1" do
    makingchange(9).should eq 2
  end
  it "test_ex2" do
    makingchange(15).should eq 6
  end
  it "test_ex3" do
    makingchange(100).should eq 292
  end
end
