#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    | line |
    numbers = {}
    line . scan (/[1-9][0-9]*/) do
        | number |
        if numbers . key? (number) then
            numbers [number] += 1
        else
            numbers [number]  = 1
        end
    end
    numbers . each do 
        | number, count |
        if count % 2 == 1 then
            puts (number)
        end
    end
end
