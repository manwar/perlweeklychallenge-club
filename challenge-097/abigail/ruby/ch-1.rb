#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb -s SHIFT < input-file
#

require 'optparse'

NR_OF_LETTERS = 26


#
# Parse and validate options
#
params = ARGV . getopts ('s:')
shift  = params ["s"] ? params ["s"] . to_i % NR_OF_LETTERS : -1

if shift < 0
    STDERR . puts "Requires a -s SHIFT option"
    exit 1
end


#
# Method to shift an upper case letter
#
def shift_letter (letter, shift)
    n = letter . ord - shift
    if   n < 'A' . ord
    then n = n + NR_OF_LETTERS
    end
    return n . chr
end


#
# Iterate over the input, shift capital letters
#
ARGF . each_line do |line|
     line = line . gsub (/[A-Z]/) {|_| shift_letter _, shift}
     puts line
end
