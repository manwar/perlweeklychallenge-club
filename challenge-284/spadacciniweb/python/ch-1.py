# Task 1: Lucky Integer
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# Write a script to find the lucky integer if found otherwise return -1. If there are more than one then return the largest.
# 
#     A lucky integer is an integer that has a frequency in the array equal to its value.
# 
# Example 1
# Input: @ints = (2, 2, 3, 4)
# Output: 2
# 
# Example 2
# Input: @ints = (1, 2, 2, 3, 3, 3)
# Output: 3
# 
# Example 3
# Input: @ints = (1, 1, 1, 3)
# Output: -1

def lucky_integer(ints):
    freq = {}
    for int in ints:
        if int in freq:
            freq[int] += 1
        else:
            freq[int] = 1

    lucky = [x for x in freq if x == freq[x]]
    print("ints (%s) -> %s" % 
            ( ", ".join( map(str,ints) ),
              max(lucky + [-1])
            )
    )

if __name__ == "__main__":
    ints = [2, 2, 3, 4]
    lucky_integer(ints)

    ints = [1, 2, 2, 3, 3, 3]
    lucky_integer(ints)

    ints = [1, 1, 1, 3]
    lucky_integer(ints)
