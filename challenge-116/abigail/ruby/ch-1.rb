#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

def make_sequence (string, start)
    if   string == start
    then return [start]
    end
    if   0 == string . index(start)
    then tail   = string [start . length, string . length]
         result = make_sequence(tail, (start . to_i + 1) . to_s) ||
                  make_sequence(tail, (start . to_i - 1) . to_s)
         if   result
         then return result . unshift (start)
         end
    end
    return nil

end

ARGF . each_line do
    |line|
    line . strip!
    for i in 1 .. line . length do
        start  = line [0, i]
        result = make_sequence(line, start)
        if   result
        then puts (result . join (","))
             break
        end
    end
end
