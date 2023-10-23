# Python code for "Same String" problem

from typing import List

def same_string(arr1: List[str], arr2: List[str]) -> bool:
    """
    Given two arrays of strings, check if the word created by concatenating the array elements is the same.
    """

    return "".join(arr1) == "".join(arr2)

# Test the function
assert same_string(["ab", "c"], ["a", "bc"]) == True
assert same_string(["ab", "c"], ["ac", "b"]) == False
assert same_string(["ab", "cd", "e"], ["abcde"]) == True

print("All tests passed.")

