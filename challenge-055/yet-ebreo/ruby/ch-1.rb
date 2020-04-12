#!/usr/bin/ruby

bin_str = ARGV[0] || '010'
len     = bin_str.length
num     = bin_str.to_i(2)

res     = []
max     = 0

for left in 0..len-1
    for right in left..len-1
        bin = num
        for number in left..right
            bin ^= 1 << len - number - 1
        end
        
        ones = bin.to_s(2).count('1')
        if ones > max then
            max = ones
            res.clear
        end
        if ones == max then
            res.push("#{left} #{right}")
        end
    end
end

puts "Pair of L-R (one's = #{max}):";
for out in res
    puts out
end

=begin
ruby .\ch-1.rb  
Pair of L-R (one's = 2):
0 0
0 2
2 2

ruby .\ch-1.rb  0101101101
Pair of L-R (one's = 7):
0 0
0 2
2 2
5 5
8 8
=end