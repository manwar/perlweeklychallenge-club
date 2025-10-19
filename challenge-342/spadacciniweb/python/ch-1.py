# Task 1: Balance String
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string made up of lowercase English letters and digits only.
# Write a script to format the give string where no letter is followed by another letter and no digit is followed by another digit. If there are multiple valid rearrangements, always return the lexicographically smallest one. Return empty string if it is impossible to format the string.
# 
# Example 1
# Input: $str = "a0b1c2"
# Output: "0a1b2c"
# 
# Example 2
# Input: $str = "abc12"
# Output: "a1b2c"
# 
# Example 3
# Input: $str = "0a2b1c3"
# Output: "0a1b2c3"
# 
# Example 4
# Input: $str = "1a23"
# Output: ""
# 
# Example 5
# Input: $str = "ab123"
# Output: "1a2b3"

def balance_string(str):
    letters = sorted( [x for x in str if x.isalpha()] )
    figures = sorted( [x for x in str if x.isnumeric()] )

    balance_string = ''
    if abs( len(letters) - len(figures) ) <= 1:
        if len(letters) > len(figures):
            balance_string += letters[0]
            letters = letters[1:]

        for i in range(0, len(letters)):
            balance_string += figures[0]
            figures = figures[1:]
            balance_string += letters[0]
            letters = letters[1:]

        if len(figures):
            balance_string += figures[0]

    print("'%s' -> '%s'" % ( str, balance_string ))

if __name__ == "__main__":
    str = "a0b1c2"
    balance_string(str)

    str = "abc12";
    balance_string(str)

    str = "0a2b1c3"
    balance_string(str)

    str = "1a23"
    balance_string(str)

    str = "ab123"
    balance_string(str)
