#!/usr/bin/env ruby
=begin
------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-21
Challenge 240 Task 01 Acronym ( Ruby )
------------------------------------
=end

mystr = [["Perl", "Python", "Pascal"],["Perl", "Raku"],["Oracle", "Awk", "C"]]
mychk = ["ppp","rp","oac"]
cnt = 0;

def GetFirstLetters(wds)
    acronym = ""
    wds.each do |w|
        acronym.concat(w[0,1])
    end
    return acronym.downcase
end

mystr.each do |str|
    puts("Input: @str = #{str}")
    puts("check = #{mychk[cnt]}")
    retval = GetFirstLetters(str)
    retval == mychk[cnt] ? puts("Output: true\n\n") : puts("Output: false\n\n")
    cnt += 1
end

=begin
------------------------------------
SAMPLE OUTPUT

ruby .\Acronym.rb

Input: @str = ["Perl", "Python", "Pascal"]
check = ppp
Output: true

Input: @str = ["Perl", "Raku"]
check = rp
Output: false

Input: @str = ["Oracle", "Awk", "C"]
check = oac
Output: true
------------------------------------
=end



