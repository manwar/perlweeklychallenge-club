#!/usr/bin/env ruby
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-21
Challenge 209 Special Bit Chars ( Ruby )
----------------------------------------
=end

bits = [[1, 0, 0],[1, 1, 1, 0]];

ln = bits.length()
flag = 0
lastchar = ''

(0..ln-1).each do |sub|
    puts("Input: @bits = #{bits[sub]}")
    ref_len = bits[sub].length()
    #puts(ref_len)
    (0..ref_len-1).each do |x|
        case bits[sub][x]
            when 1
                if flag == 0
                    flag = 1
                else
                    print('c ')
                    lastchar = 'c'
                    flag = 0
                end
            when 0
                if flag == 0
                    print('a ')
                    lastchar = 'a'
                elsif flag == 1
                    print('b ')
                    lastchar = 'b'
                    flag = 0
                end
        end
    end
    puts(" ")
    if (lastchar == 'a' and flag == 0)
        puts("Output: 1")
    else
        puts("Output: 0")
    end
    puts(" ")
end

=begin
----------------------------------------
SAMPLE OUTPUT
ruby .\SpecialBit.rb
Input: @bits = [1, 0, 0]
b a
Output: 1

Input: @bits = [1, 1, 1, 0]
c b
Output: 0
----------------------------------------
=end
