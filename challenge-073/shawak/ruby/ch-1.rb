a=gets.split.map &:to_i
s=gets.to_i/2
p (s...a.size-s).map{|x|a[x-s..x+s].min}
