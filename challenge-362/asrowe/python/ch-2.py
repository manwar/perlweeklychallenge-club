# You are given an array of integers.

# Write a script to return them in alphabetical order, in any language of your choosing. Default language is English.

# Example 1
# Input: (6, 7, 8, 9 ,10)
# Output: (8, 9, 7, 6, 10)

# eight, nine, seven, six, ten

# Example 2
# Input: (-3, 0, 1000, 99)
# Output: (-3, 99, 1000, 0)

# minus three, ninety-nine, one thousand, zero

# Example 3
# Input: (1, 2, 3, 4, 5)

# Output: (5, 2, 4, 3, 1) for French language
# cinq, deux, quatre, trois, un

# Output: (5, 4, 1, 3, 2) for English language
# five, four, one, three, two

# Example 4
# Input: (0, -1, -2, -3, -4)
# Output: (-4, -1, -3, -2, 0)

# minus four, minus one, minus three, minus two, zero

# Example 5
# Input: (100, 101, 102)
# Output: (100, 101, 102)

# one hundred, one hundred and one, one hundred and two

from num2words import num2words

def spellboundSort(input: list) -> list:
    out = sorted(input, key=num2words)
    return out

def dev():
    cases = [[6, 7, 8, 9 ,10], [-3, 0, 1000, 99], [1, 2, 3, 4, 5], [0, -1, -2, -3, -4], [100, 101, 102]]
    for case in cases:
        print(case, " => " ,spellboundSort(case))



if __name__ == '__main__':
    dev()
