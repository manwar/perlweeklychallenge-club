#!/usr/bin/env ruby
=begin
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-24
Challenge 227 Task 1 Fridat 13th ( Ruby )
-------------------------------------
=end
require 'date'

year = ARGV[0].to_i
if year < 1753 || year > 9999
    puts("Please supply a year between 1753 and 9999")
    exit
end

month = 1
while month <= 12
    d = Date.new(year,month,13).wday
    if d == 5
        puts("#{year} #{month} 13  is a Friday")
    end
    month += 1
end

=begin
-------------------------------------
SAMPLE OUTPUT
ruby .\Friday13.rb 2023

2023 1 13  is a Friday
2023 10 13  is a Friday

ruby .\Friday13.rb 1753

1753 4 13  is a Friday
1753 7 13  is a Friday
-------------------------------------
=end


