#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR : Robert DiCicco
DATE   : 2023-10-21
Challenge 239 Task 02 Consistent Strings ( Ruby )
--------------------------------------
=end

mystr = Array["ad", "bd", "aaab", "baa", "badab", "ab"],
              ["a", "b", "c", "ab", "ac", "bc", "abc","abc"],
              ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d","cad"]
cnt = 0

def CheckConsistent(str, mallowed)
    total = 0
    m_arr = mallowed.split('')
    i = 0
    while i < str.length() - 1
        s_arr = str[i].split('')
        df = s_arr - m_arr
        if df.empty?
            total += 1
        end
        i += 1
    end
    return total
end

while cnt < mystr.length() do
    ln = mystr[cnt].length() - 2
    puts("Input: @str = #{mystr[cnt][0..ln]}")
    puts("Allowed = #{mystr[cnt].last()}")
    mallow = mystr[cnt].last()
    retval = CheckConsistent(mystr[cnt], mallow)
    puts("Output: #{retval}\n\n")
    cnt += 1
end

=begin
---------------------------------------
SAMPLE OUTPUT

ruby .\Consistent.rb

Input: @str = ["ad", "bd", "aaab", "baa", "badab"]
Allowed = ab
Output: 2

Input: @str = ["a", "b", "c", "ab", "ac", "bc", "abc"]
Allowed = abc
Output: 7

Input: @str = ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]
Allowed = cad
Output: 4
--------------------------------------
=end



