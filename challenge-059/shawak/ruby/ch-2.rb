a=gets.split(',').map &:to_i
a=a.combination(2).map{|a,b| [a.to_s(2), b.to_s(2)]}
puts a.sum{|a,b|
    ([a.size, b.size].max-1).downto(0).count {|i|
        a[i] == b[i] || !a[i] || !b[i]
    }
}
