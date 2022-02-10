#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do |line|
    tree = line . strip() . split(/\|/) . map do |row|
        row . strip() . split(/ +/) . map do |x|
            x == "*" ? false : true
        end
    end
    done = false
    for d in 0 .. tree . length() - 1 do
        for i in 0 .. tree [d] . length() - 1 do
            if tree [d] [i] && !tree [d + 1] [2 * i] &&
                               !tree [d + 1] [2 * i + 1] then
                puts (d + 1)
                done = true
                break
            end
        end
        if done then
            break
        end
    end
end
