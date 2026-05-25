
def k_beauty(num, k)
  num.to_s.chars.each_cons(k).map{|n| n.join.to_i }.filter{|n| num % n == 0 }.length
end

raise if k_beauty(240, 2)  != 2
raise if k_beauty(1020, 2) != 3
raise if k_beauty(444, 2)  != 0
raise if k_beauty(17, 2)   != 1
raise if k_beauty(123, 1)  != 2

