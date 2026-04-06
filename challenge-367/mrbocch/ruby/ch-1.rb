
def max_odd_binary(str)
  str.split("").permutation.map{|s| s.join}.uniq.map{|s| s.to_i(2)}.filter(&:odd?).max.to_s(2).rjust(str.size, "0")
end

raise "Error: Example 1" if max_odd_binary("1011")   != "1101"
raise "Error: Example 2" if max_odd_binary("100")    != "001"
raise "Error: Example 3" if max_odd_binary("111000") != "110001"
raise "Error: Example 4" if max_odd_binary("0101")   != "1001"
raise "Error: Exampel 5" if max_odd_binary("1111")   != "1111"
