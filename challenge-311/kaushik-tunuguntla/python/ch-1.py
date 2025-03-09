# Task 1: Upper Lower
# Submitted by: Mohammad Sajid Anwar
# You are given a string consists of english letters only.
# 
# Write a script to convert lower case to upper and upper case to lower in the given string.
# 
# Example 1
# Input: $str = "pERl"
# Output: "PerL"
# Example 2
# Input: $str = "rakU"
# Output: "RAKu"
# Example 3
# Input: $str = "PyThOn"
# Output: "pYtHoN"

mystring = input("Enter any string to switch case: ")
print(f"original string: {mystring}")

newstring = mystring.swapcase()
print(f"transformed string: {newstring}")
