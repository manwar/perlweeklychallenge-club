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

tr_letter = lambda x, y: chr((ord(x) - 97 + y) % 26 + 97) if (ord(x) >= 97) else chr((ord(x) - 65 + y) % 26 + 65)
    
def tr_word(word, jump):
    return ''.join(list(map(tr_letter, word, jump)))
    
if __name__ == "__main__":
    word = 'Perl'
    jump = [2,22,19,9]
    print(tr_word(word, jump))

    word = 'Raku';
    jump = [24,4,7,17]
    print(tr_word(word, jump))
