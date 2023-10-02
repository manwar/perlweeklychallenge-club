#!/usr/bin/env ruby
=begin
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-05
Challenge 220 Task 1 common Characters ( Ruby )
------------------------------------------------
=end

words = [["Perl", "Rust", "Raku"], ["love", "live", "leave"]];

str = ('a' .. 'z')

alphabet_hash = {}

words.each do |wds|
    str.each do |letter|
        alphabet_hash[letter] = 0
    end
    puts("Input: @words = #{wds}")
    wds.each do |wd|
        wd = wd.downcase
        myarr = wd.chars
        myarr.each do |ch|
            total = alphabet_hash[ch].to_i
            total += 1
            alphabet_hash[ch] = total
        end
    end
    print("Output : (")
    alphabet_hash.each do |key, val|
        if val >= 3
            print("#{key} ")
        end
    end
    print(")\n\n")
end

=begin
------------------------------------------------
SAMPLE OUTPUT
ruby .\CommomChars.rb

Input: @words = ["Perl", "Rust", "Raku"]
Output : (r )

Input: @words = ["love", "live", "leave"]
Output : (e l v )
------------------------------------------------
=end

