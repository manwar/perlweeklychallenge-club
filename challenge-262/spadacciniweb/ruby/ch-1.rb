# Task 1: Max Positive Negative
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# Write a script to return the maximum number of either positive or negative integers in the given array.
# 
# Example 1
# Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
# Output: 4
# 
# Count of positive integers: 4
# Count of negative integers: 3
# Maximum of count of positive and negative integers: 4
# 
# Example 2
# Input: @ints = (-1, -2, -3, 1)
# Output: 3
# 
# Count of positive integers: 1
# Count of negative integers: 3
# Maximum of count of positive and negative integers: 3
# 
# Example 3
# Input: @ints = (1,2)
# Output: 2
# 
# Count of positive integers: 2
# Count of negative integers: 0
# Maximum of count of positive and negative integers: 2

def maximum_of_positive_and_negative(ints)
    positive = ints.select {|i| i > 0}.size
    negative = ints.select {|i| i < 0}.size

    printf "(%s) -> %s\n",
        ints.join(","),
        [positive,negative].max
end

ints = [-3, 1, 2, -1, 3, -2, 4]
maximum_of_positive_and_negative(ints)

ints = [-1, -2, -3, 1]
maximum_of_positive_and_negative(ints)

ints = [1,2]
maximum_of_positive_and_negative(ints)
