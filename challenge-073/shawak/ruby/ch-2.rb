a=gets.split.map &:to_i
p (0...a.size).map{|x|a[0..x].select{|y|y<a[x]}.sort.first||0}
