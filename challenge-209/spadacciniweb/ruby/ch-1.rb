# Task 1: Special Bit Characters
# Submitted by: Mohammad S Anwar
# 
# You are given an array of binary bits that ends with 0.
# 
# Valid sequences in the bit string are:
# 
# [0] -decodes-to-> "a"
# [1, 0] -> "b"
# [1, 1] -> "c"
# Write a script to print 1 if the last character is an “a” otherwise print 0.
#
# Example 1
# Input: @bits = (1, 0, 0)
# Output: 1
# 
# The given array bits can be decoded as 2-bits character (10) followed by 1-bit character (0).
# 
# Example 2
# Input: @bits = (1, 1, 1, 0)
# Output: 0
# 
# Possible decode can be 2-bits character (11) followed by 2-bits character (10) i.e. the last character is not 1-bit character.

def main(input)
    if input.length < 1 \
       or \
       input.select{ |i| i[/[^01]/] }.length > 0
    then
        puts "Input error"
        exit(0)
    end

    while input.length > 1
        c = input.shift
        if c == '1'
            input.shift
        end
    end
    if input.length > 0 and input[0] == '1'
        puts "Input error"
        exit(0)
    end
    printf "%d\n", (input.length > 0) ? 1 : 0;
end

main ARGV
