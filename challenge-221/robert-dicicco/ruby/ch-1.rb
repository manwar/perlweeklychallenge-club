#!/usr/bin/env ruby
=begin
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-12
Challenge 221 Task 1 Good Strings ( Ruby )
-------------------------------------
=end

total_score = 0

words = [["cat", "bt", "hat", "tree"], ["hello", "world", "challenge"]]
chlist = ["atach","welldonehopper"]
cnt = 0
listcnt = 0

words.each do |wds|
    puts("Input: @words = #{wds}")
    chars = chlist[cnt]
    total_score = 0
    wds.each do |w|
        ln = w.length
        score = 0
        for cnt in 0..ln-1 do
            tst = w[cnt,1]
            if chlist[listcnt].include? tst
                 score += 1
            else
                break
            end
        end
        if score == ln
            puts("#{w}")
            total_score += score
            score = 0
         end
    end
    puts("\tTotal: #{total_score}\n\n")
    cnt += 1
    listcnt += 1
end

=begin
-------------------------------------
SAMPLE OUTPUT
ruby .\GoodStrings.rb
Input: @words = ["cat", "bt", "hat", "tree"]
cat
hat
        Total: 6

Input: @words = ["hello", "world", "challenge"]
hello
world
        Total: 10
-------------------------------------
=end





