require 'prime'
p Prime.prime_division(gets.to_i).select{|a|a[1]>1}.size>0?1:0
