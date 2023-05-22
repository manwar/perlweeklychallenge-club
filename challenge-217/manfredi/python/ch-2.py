#!/usr/bin/env python3
# Python 3.9.2 on Debian GNU/Linux 11 (bullseye)

print('challenge-217-task2')

# Task 2: Max Number
# You are given a list of positive integers.
# Write a script to concatenate the integers to form the highest possible value.

# Example 1
# Input: @list = (1, 23)
# Output: 231

# Example 2
# Input: @list = (10, 3, 2)
# Output: 3210

# Example 3
# Input: @list = (31, 2, 4, 10)
# Output: 431210

def max_number(nums: list[int]) -> int:
    print(f"Input: list = {nums}")
    out = ''.join(sorted([ str(i) for i in nums], reverse = True))
    return int(out)


def main():    
    print("Output: ", max_number([1, 23]), "\n")
    print("Output: ", max_number([10, 3 ,2]), "\n")
    print("Output: ", max_number([31, 2 , 4, 10]), "\n")
    print("Output: ", max_number([5, 11, 4, 1, 2]), "\n")
    print("Output: ", max_number([1, 10]), "\n")


if __name__ == '__main__':
    main()
