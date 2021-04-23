#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb
#

COUNT   = 10
PLAIN   =  0
COMPUTE =  1

type = PLAIN

if   ARGV . length > 0 && ARGV[0] == "compute"
then type = COMPUTE
end

if   type == PLAIN
then puts ("1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147");
end

if   type == COMPUTE
then bell = [[1]]
     for  x in 1 .. COUNT - 2
          bell [x] = [bell [x - 1] [x - 1]]
          for  y in 1 .. x
               bell [x] [y] = bell [x] [y - 1] + bell [x - 1] [y - 1]
          end
     end
     print (1)
     for  x in 0 .. COUNT - 2
          print (", ")
          print (bell [x] [x])
     end
     puts ("")
end
