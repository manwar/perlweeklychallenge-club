#!/usr/bin/ruby

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

=begin
ruby .\ch-2.rb  1 2 3 4
2 1 4 3
3 1 4 2
3 2 4 1
4 1 3 2
4 2 3 1

ruby .\ch-2.rb  1 2 2 3 4
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
=end