#!/usr/bin/ruby

start_time = Time.now
narray = (ARGV.sort)
hash   = {}
for elem in narray.permutation.to_a
    flag = 1
    for e in 1..elem.length-1
         e % 2 > 0?
            flag &= (elem[e] <= elem[e-1] ? 1 : 0)
        :
            flag &= (elem[e] >= elem[e-1] ? 1 : 0)
        
        break if !flag
    end
    if flag > 0
        hold = elem.join(' ')
        puts hold if !hash[hold]
        hash[hold] = 1
    end
end
puts "Execution Time: #{Time.now - start_time} seconds"
=begin
ruby .\ch-2.rb 1 2 3 4
2 1 4 3
3 1 4 2
3 2 4 1
4 1 3 2
4 2 3 1
Execution Time: 0.001842 seconds

ruby .\ch-2.rb 1 2 2 3 4
2 1 3 2 4
2 1 4 2 3
2 2 3 1 4
2 2 4 1 3
3 1 2 2 4
3 1 4 2 2
3 2 2 1 4
3 2 4 1 2
4 1 2 2 3
4 1 3 2 2
4 2 2 1 3
4 2 3 1 2
Execution Time: 0.0028966 seconds

ruby .\ch-2.rb 1 2 3 4 5 6 7 8 9
..
9 7 8 4 6 3 5 1 2
9 7 8 5 6 1 3 2 4
9 7 8 5 6 1 4 2 3
9 7 8 5 6 2 3 1 4
9 7 8 5 6 2 4 1 3
9 7 8 5 6 3 4 1 2
Execution Time: 7.6230353 seconds

ruby .\ch-2.rb 1 2 3 4 5 6 7 8 9 10
..
9 7 8 5 6 2 3 1 4 10
9 7 8 5 6 2 3 10 4 1
9 7 8 5 6 2 4 1 3 10
9 7 8 5 6 2 4 10 3 1
9 7 8 5 6 3 4 1 2 10
9 7 8 5 6 3 4 10 2 1
Execution Time: 60.9326917 seconds
=end