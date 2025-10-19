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

def balance_string(str)
    letters = str.chars.select { |s| /[a-zA-Z]/ =~ s }.sort
    figures = str.chars.select { |s| /\d/ =~ s }.sort
    balance_string = ""

    if (letters.length - figures.length).abs <= 1
        if letters.length > figures.length
            balance_string += letters.shift
        end
        
        (1..letters.length).each do |_|
            balance_string += figures.shift
            balance_string += letters.shift
        end
        if figures.length > 0
            balance_string += figures.shift
        end
    end

    printf "'%s' -> '%s'\n", str, balance_string
end

str = "a0b1c2"
balance_string(str);

str = "abc12"
balance_string(str)

str = "0a2b1c3"
balance_string(str)

str = "1a23"
balance_string(str)

str = "ab123"
balance_string(str)
