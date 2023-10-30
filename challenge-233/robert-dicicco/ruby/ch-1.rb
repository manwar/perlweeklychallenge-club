#!/usr/bin/env ruby
=begin
AUTHOR: Robert DiCicco
DATE  : 2023-09-09
Challenge 233 Task one Similar Words ( Ruby )
=end

words = ["aba", "aabb", "abcd", "bac", "aabc"]
#words = ["aabb", "ab", "ba"]

ax = words.combination(2).to_a
pairs = 0
cnt = 1
puts("Input: @words = #{words}")
ax.each do |res|
    str1 = res[0].split(//).sort.uniq.join("")
    str2 = res[1].split(//).sort.uniq.join("")
    if str1 == str2
        puts("\tpair#{cnt} \[#{res[0]} #{res[1]}\]")
        pairs += 1
        cnt += 1
    end
end
puts("Output: #{pairs}")

=begin
SAMPLE OUTPUT
ruby .\SimilarWords.rb

Input: @words = ["aabb", "ab", "ba"]
        pair1 [aabb ab]
        pair2 [aabb ba]
        pair3 [ab ba]
Output: 3

ruby .\SimilarWords.rb

Input: @words = ["aba", "aabb", "abcd", "bac", "aabc"]
        pair1 [aba aabb]
        pair2 [bac aabc]
Output: 2
=end


