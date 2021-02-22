#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

numbers = []

#
# Parse the data: iterate over the lines of input, split each
# line on whitespace, turn each item into an integer, and
# add the split elements as a row of numbers to the array numbers.
#
ARGF . each_line do |_|
    numbers << _ . split . map {|_| _ . to_i}
end

#
# Calculate the minimum path, bottom to top
#
(numbers . length - 2) . downto (0) do |x|
    (0) . upto (numbers [x] . length - 1) do |y|
        numbers [x] [y] += [numbers [x + 1] [y],
                            numbers [x + 1] [y + 1]] . min
    end
end

#
# Print result
#
puts numbers [0] [0]
