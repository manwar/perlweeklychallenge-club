#!/usr/bin/env ruby
=begin
-----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-22
Challenge 222 Task 2 Last Member ( Ruby )
-----------------------------------------------
=end

allints = Array.new
for i in 0 ... ARGV.length
   allints << ARGV[i].to_i
end
puts("Input: @ints = #{allints}")
loop do
  srt = allints.sort
  elems = srt.length()
  if elems <= 1
    puts("Output: #{elems}\n\n")
    exit
  else
    lrg = srt.last
    nxt = srt[elems-2]
    index = allints.find_index(lrg)
    allints.delete_at(index)
    index = allints.find_index(nxt)
    allints.delete_at(index)
    newmember = lrg - nxt
    if lrg > nxt
        allints.push(newmember)
    end
  end
end

=begin
-----------------------------------------------
SAMPLE OUTPUT
ruby .\LastMember.rb 2 7 4 1 8 1
Input: @ints = [2, 7, 4, 1, 8, 1]
Output: 1

ruby .\LastMember.rb 1 1
Input: @ints = [1, 1]
Output: 0

ruby .\LastMember.rb 1
Input: @ints = [1]
Output: 1
-----------------------------------------------
=end


