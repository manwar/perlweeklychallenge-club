#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE:   2023-01-23

Challenge 201 Missing Numbers ( Ruby )

=end



arrs = [[0,1,3],[0,1]]



arrs.each do |arr|

    puts("Input: \@array = #{arr}")

    len = arr.length();

    for x in 0..len

        unless arr.include? x

            puts("Output: #{x}","")

        end

    end

end



=begin

SAMPLE OUTPUT

ruby .\MissingNumbers.rb

Input: @array = [0, 1, 3]

Output: 2



Input: @array = [0, 1]

Output: 2

=end
