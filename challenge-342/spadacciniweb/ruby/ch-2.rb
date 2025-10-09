# Task 2: Max Score
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str, containing 0 and 1 only.
# Write a script to return the max score after splitting the string into two non-empty substrings. The score after splitting a string is the number of zeros in the left substring plus the number of ones in the right substring.
# 
# Example 1
# Input: $str = "0011"
# Output: 4
# 
# 1: left = "0", right = "011" => 1 + 2 => 3
# 2: left = "00", right = "11" => 2 + 2 => 4
# 3: left = "001", right = "1" => 2 + 1 => 3
# 
# Example 2
# Input: $str = "0000"
# Output: 3
# 
# 1: left = "0", right = "000" => 1 + 0 => 1
# 2: left = "00", right = "00" => 2 + 0 => 2
# 3: left = "000", right = "0" => 3 + 0 => 3
# 
# Example 3
# Input: $str = "1111"
# Output: 3
# 
# 1: left = "1", right = "111" => 0 + 3 => 3
# 2: left = "11", right = "11" => 0 + 2 => 2
# 3: left = "111", right = "1" => 0 + 1 => 1
# 
# Example 4
# Input: $str = "0101"
# Output: 3
# 
# 1: left = "0", right = "101" => 1 + 2 => 3
# 2: left = "01", right = "01" => 1 + 1 => 2
# 3: left = "010", right = "1" => 2 + 1 => 3
# 
# Example 5
# Input: $str = "011101"
# Output: 5
# 
# 1: left = "0", right = "11101" => 1 + 4 => 5
# 2: left = "01", right = "1101" => 1 + 3 => 4
# 3: left = "011", right = "101" => 1 + 2 => 3
# 4: left = "0111", right = "01" => 1 + 1 => 2
# 5: left = "01110", right = "1" => 2 + 1 => 3

def max_score(str)
    max_score = 0

    if str.length > 2
        (0 .. str.length-2).each do |i|
            left = str[0..i]
            right = str[i+1..]
            score = left.split('').select { |x| x == "0" }.length +
                    right.split('').select { |x| x == "1" }.length
            if score > max_score
                max_score = score
            end
        end
    end

    printf "'%s' -> %d\n", str, max_score
end

str = "0011"
max_score(str)

str = "0000"
max_score(str)

str = "1111"
max_score(str)

str = "0101"
max_score(str)

str = "011101"
max_score(str)
