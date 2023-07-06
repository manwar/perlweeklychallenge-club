#!/usr/bin/env ruby
=begin
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-03
Challenge 224 Task 1 Special Notes ( Ruby )
----------------------------------------------
=end

source = ARGV[0]
target = ARGV[1]

flag = 0
offset = 0

while offset < target.length()
    letter = target[offset,1]
    if not source.include? letter
        puts "Output: false";
        flag = -1;
        break
    end
    offset += 1
end

if flag == 0
    puts("Output: true")
end

=begin
----------------------------------------------
ruby .\SpecialNotes.rb abc xyz
Output: false

ruby .\SpecialNotes.rb scriptinglanguage perl
Output: true

ruby .\SpecialNotes.rb aabbcc abc
Output: true
----------------------------------------------
=end


