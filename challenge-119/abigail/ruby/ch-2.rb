#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

def next_num (prev_num)
    ("0" + prev_num) . match (/^(.*)([012])(3*)$/) do
        |match|
        return (match [1] + (1 + match [2] . to_i) . to_s +
                match [3] . gsub(/3/, "1")) . gsub(/11/, "12") . gsub(/^0/, "")
    end
end


ARGF . each_line do
    |num|
    number = "0"
    for i in 1 .. num . to_i do
        number = next_num (number)
    end
    puts (number)
end
