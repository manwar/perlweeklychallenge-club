p gets[1..-3].split(?,).map{|x|x.chomp.to_i}.each_cons(2).map{|a,b|a*b}.sort[-1]
