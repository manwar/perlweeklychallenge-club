# Task 1: Jumping Letters
# Submitted by: Mohammad S Anwar
#
# You are given a word having alphabetic characters only, and a list of positive integers of the same length
#
# Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list. The given list would have exactly the number as the total alphabets in the given word.
#
# Example 1
# Input: $word = 'Perl' and @jump = (2,22,19,9)
# Output: Raku
# 'P' jumps 2 place forward and becomes 'R'.
# 'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z' you go back to 'a')
# 'r' jumps 19 place forward and becomes 'k'.
# 'l' jumps 9 place forward and becomes 'u'.

# Example 2
# Input: $word = 'Raku' and @jump = (24,4,7,17)
# Output: 'Perl'

def tr_letter(char,jump)
    order = char.ord()
    if (order >= 97)
    then
        return ( ( order - 97 + jump ) % 26 + 97 ).chr()
    else
        return ( ( order - 65 + jump ) % 26 + 65 ).chr()
    end
end

def tr_word(word, jump)
    new_word = ''
    (0...word.length).each { |i|
        new_word += tr_letter word[i], jump[i]
    }
    return new_word
end

word = 'Perl'
jump = [2,22,19,9]
puts tr_word word, jump

word = 'Raku'
jump = [24,4,7,17]
puts tr_word word, jump
