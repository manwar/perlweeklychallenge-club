#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-07
Challenge 229 Lexical Order Task 1 ( Ruby )
---------------------------------------
=end

strs = [["abc", "bce", "cae"],["yxz", "cba", "mon"]]

cnt = 0

def CheckLexOrder(e)
    lexstr = e.chars.sort.join
    if e == lexstr
        return 1
    elsif e == lexstr.reverse
        return 1
    else
        return 0
    end
end

strs.each do |str|
    puts("Input: @str = #{str}")
    str.each do |elm|
        retval = CheckLexOrder(elm)
        if retval == 0
            cnt += 1
        end
    end
    puts("Output: #{cnt}\n\n")
    cnt = 0
end

=begin
---------------------------------------
SAMPLE OUTPUT
ruby .\LexOrder.rb

Input: @str = ["abc", "bce", "cae"]
Output: 1

Input: @str = ["yxz", "cba", "mon"]
Output: 2
---------------------------------------
=end


