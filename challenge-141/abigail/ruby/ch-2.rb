#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def substrings (n, m, prefix, max)
    if n . length == 0 then
        return prefix > -1  &&
               prefix < max &&
               prefix % m == 0 ? 1 : 0
    end

    fc   = n[0] . to_i
    tail = n[1 .. -1]
    if prefix == -1 then
        n_prefix = fc
    else
        n_prefix = 10 * prefix + fc
    end

    return substrings(tail, m, n_prefix, max) +
           substrings(tail, m,   prefix, max)
end
           

ARGF . each_line do
    | line |
    n, m = line . strip() . split
    puts substrings(n, m . to_i, -1, n . to_i)
end
