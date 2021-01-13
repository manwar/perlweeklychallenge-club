#!/usr/bin/ruby

while line = gets do
     line = line . rstrip
     puts line . length
     puts line . tr('ATCG', 'TAGC')
end
