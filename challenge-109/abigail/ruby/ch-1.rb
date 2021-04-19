#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb [plain | compute]
#

PLAIN   =  0
COMPUTE =  1

COUNT   = 20

def divisor_sum (n)
    sum = 0
    for i in 2 .. n - 1
        if   n % i == 0
        then sum += i
        end
    end
    return sum
end

type = PLAIN

if   ARGV . length > 0 && ARGV[0] == "compute"
then type = COMPUTE
end

if   type == PLAIN
then puts ("0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21");
end

if   type == COMPUTE
then for n in 1 .. COUNT
         if n > 1
         then print (", ")
         end
         print divisor_sum (n)
     end
     puts ("")
end
