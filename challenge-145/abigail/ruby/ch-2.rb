#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    | line |
    line = line . strip
    palindromes = {}
    for i in 0 .. line . length - 1 do
        for j in i .. line . length - 1 do
            string = line [i .. j]
            if string == string . reverse then
                palindromes [string] = 1
            end
        end
    end
    palindromes . each_key do
        | key |
        print key
        print " "
    end
    puts ""
end
