#!/usr/bin/env ruby
=begin
----------------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-26
Challenge 209 Merge Account ( Ruby )
----------------------------------------------------------
=end

accounts = [["A", "a1\@a.com", "a2\@a.com"], ["B", "b1\@b.com"], ["A", "a3\@a.com", "a1\@a.com"]]
#accounts = [ ["A", "a1\@a.com", "a2\@a.com"], ["B", "b1\@b.com"], ["A", "a3\@a.com"], ["B", "b2\@b.com", "b1\@b.com"] ]
puts("Input: @accounts = #{accounts}")
a = Array.new()
b = Array.new()
accounts.each do |sub|
    if (sub[0] == 'A')
        sub.each do |x|
            a.push(x)
        end
    end
    if (sub[0] == 'B')
        sub.each do |y|
            b.push(y)
        end
    end
end

puts("Output: ")
puts("\t#{a.uniq}")
puts("\t#{b.uniq}")

=begin
----------------------------------------------------------
SAMPLE OUTPUT
ruby .\MergeAccount.rb
Input: @accounts = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com", "a1@a.com"]]
Output:
        ["A", "a1@a.com", "a2@a.com", "a3@a.com"]
        ["B", "b1@b.com"]


PS G:\Projects\Perl\Challenges> ruby .\MergeAccount.rb
Input: @accounts = [["A", "a1@a.com", "a2@a.com"], ["B", "b1@b.com"], ["A", "a3@a.com"], ["B", "b2@b.com", "b1@b.com"]]
Output:
        ["A", "a1@a.com", "a2@a.com", "a3@a.com"]
        ["B", "b1@b.com", "b2@b.com"]
----------------------------------------------------------
=end


