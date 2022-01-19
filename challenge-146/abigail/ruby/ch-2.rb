#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

ARGF . each_line do
    | line |
    a, b = line . strip() . split("/") . map {|x| x . to_i}
    for i in 1 .. 2 do
        if a < b then
            b -= a
        else
            a -= b
        end
        if a == 0 || b == 0 then
            next
        end
        print a, "/", b, " "
    end
    puts ("")
end
