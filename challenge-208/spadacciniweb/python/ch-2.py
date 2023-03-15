# Task 2: Duplicate and Missing
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers in sequence with one missing and one duplicate.
# Write a script to find the duplicate and missing integer in the given array. Return -1 if none found.
# For the sake of this task, let us assume the array contains no more than one duplicate and missing.
# 
# Example 1:
# Input: @nums = (1,2,2,4)
# Output: (2,3)
# Duplicate is 2 and Missing is 3.
# 
# Example 2:
# Input: @nums = (1,2,3,4)
# Output: -1
# No duplicate and missing found.
# 
# Example 3:
# Input: @nums = (1,2,3,3)
# Output: (3,4)
# Duplicate is 3 and Missing is 4.

def duplicate_and_missing(list1):
    duplicate_and_missing = set()
    for i in range(0, len(list1)):
        if len(list(filter(lambda x: list1[i] == x, list1))) > 1:
            duplicate_and_missing.add(list1[i])
            break
    for i in range(list1[0], list1[0]+len(list1)):
        if len(list(filter(lambda x: i == x, list1))) == 0:
            duplicate_and_missing.add(i)
    if len(list(duplicate_and_missing)) > 1:
        print("({:s})".format(', '.join([str(x) for x in duplicate_and_missing])))
    else:
        print('-1')

if __name__ == "__main__":
    duplicate_and_missing([1,2,2,4])
    duplicate_and_missing([1,2,3,4])
    duplicate_and_missing([1,2,3,3])
