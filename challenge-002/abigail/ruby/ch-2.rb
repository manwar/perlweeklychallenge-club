#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb {-f | -t} < input-file
#

require 'optparse'

BASE = 35

#
# Parse and validate options
#
params = ARGV . getopts ('ft')
do_from_base = params ["f"] ? 1 : 0
do_to_base   = params ["t"] ? 1 : 0
if do_from_base + do_to_base != 1
    STDERR . puts "Program requires exactly one of '-f' or '-t'"
    exit 1
end


def to_base (number)
    out = ""
    while number > 0 do
        rest = number % BASE
        if rest < 10
        then char = rest . to_s
        else char = (65 + rest - 10) . chr
        end
        out = char + out
        number = (number / BASE) . to_i
    end
    return out
end

def from_base (number)
    return number . to_i (35)
end

ARGF . each_line do |_|
    if   do_from_base == 1
    then puts from_base (_)
    else puts to_base (_ . to_i)
    end
end
