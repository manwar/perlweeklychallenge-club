#!/usr/local/bin/python3

# Task 1: Same String
# Write a script to find out if the word created by concatenating the array elements is the same.

def check_equality(arr1, arr2):
    print(arr1 == arr2)

# Example 1
arr1 = ["ab", "c"]
arr2 = ["a", "bc"]        
check_equality(''.join(arr1), ''.join(arr2))

# Example 2
arr1 = ["ab", "c"]
arr2 = ["ac", "b"]        
check_equality(''.join(arr1), ''.join(arr2)) 

# Example 3
arr1 = ["ab", "cd", "e"]
arr2 = ["abcde"]        
check_equality(''.join(arr1), ''.join(arr2)) 
