#!/usr/bin/env ruby
=begin
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-13
Challenge 234 Task 1 Common Characters ( Ruby )
------------------------------------------------
=end

wordlist = [["java", "javascript", "julia"],["bella", "label", "roller"],["cool", "lock", "cook"]]

wordlist.each do |wds|
    charset = ""
    seen = Hash.new
    ("a".."z").each do |ch|
        seen[ch] = 0
    end
    puts("Input: @wordlist = #{wds}")
    wordnum = wds.length
    cnt = 0
    wds.each do |w|
         charset += w
    end
    arr = charset.split("")
    arr.each do |i|
        seen[i] += 1
    end

    print("Output: (")
    seen.each do |key, val|
        if  val >= wordnum && val < (2 * wordnum)
            print("#{key} ")
        elsif val == (2 * wordnum)
            print("#{key} #{key} ")
        end
    end
    puts(")\n\n")
end

=begin
------------------------------------------------
SAMPLE OUTPUT
ruby .\CommonCharacters.rb
Input: @wordlist = ["java", "javascript", "julia"]
Output: (a j )

Input: @wordlist = ["bella", "label", "roller"]
Output: (e l l )

Input: @wordlist = ["cool", "lock", "cook"]
Output: (c o )
------------------------------------------------
=end


