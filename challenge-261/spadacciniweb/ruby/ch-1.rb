# Task 1: Element Digit Sum
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# Write a script to evaluate the absolute difference between element and digit sum of the given array.
# 
# Example 1
# Input: @ints = (1,2,3,45)
# Output: 36
# 
# Element Sum: 1 + 2 + 3 + 45 = 51
# Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
# Absolute Difference: | 51 - 15 | = 36
# 
# Example 2
# Input: @ints = (1,12,3)
# Output: 9
# 
# Element Sum: 1 + 12 + 3 = 16
# Digit Sum: 1 + 1 + 2 + 3 = 7
# Absolute Difference: | 16 - 7 | = 9
# 
# Example 3
# Input: @ints = (1,2,3,4)
# Output: 0
# 
# Element Sum: 1 + 2 + 3 + 4 = 10
# Digit Sum: 1 + 2 + 3 + 4 = 10
# Absolute Difference: | 10 - 10 | = 0
# 
# Example 4
# Input: @ints = (236, 416, 336, 350)
# Output: 1296

def absolute_difference(ints)
    digits_sum = 0
    ints.each do |i|
        digits_sum += i.to_s.chars.map { |digit| digit.to_i }.sum
    end

    printf "(%s) -> %s\n",
        ints.join(","),
        (ints.sum - digits_sum).abs
end

ints = [1,2,3,45]
absolute_difference(ints);

ints = [1,12,3]
absolute_difference(ints);

ints = [1,2,3,4]
absolute_difference(ints);

ints = [236, 416, 336, 350]
absolute_difference(ints);
