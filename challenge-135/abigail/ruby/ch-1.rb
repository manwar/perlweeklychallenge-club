#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    | line |
    line = line . strip() . gsub(/^[-+]/, "")
    ll   = line . length
    if line . match (/[^0-9]/) then
        puts ("not an integer")
    elsif ll % 2 == 0 then
        puts ("even number of digits")
    elsif ll < 3 then
        puts ("too short")
    else
        puts (line [((ll - 3) / 2) . to_i .. ((ll + 2) / 2) . to_i])
    end
end
