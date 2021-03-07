#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

require "optparse"

#
# Parse options
#
params   = ARGV . getopts ('f:')
filename = params ["f"]


#
# Find words from the file 'filename' which can be made
# from the letters in 'letters'.
#
def find_words (filename, letters)
    letters = letters . downcase . split (//)
    File . open (filename) do |f|
        f . each_line do |word|
            copy = word . downcase
            letters . each do |letter|
                copy . sub! letter, ""
            end
            if copy == ""
                puts (word)
            end
        end
    end
end


ARGF . each_line do |letters|
    find_words filename, letters
end
