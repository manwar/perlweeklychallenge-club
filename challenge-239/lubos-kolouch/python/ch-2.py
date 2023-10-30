# Python implementation of the "Consistent Strings" problem
from typing import List

def count_consistent_strings(strings: List[str], allowed: str) -> int:
    """
    Given a list of strings and an allowed string with distinct characters,
    this function returns the number of consistent strings in the list.
    A string is consistent if all its characters are in the allowed string.
    """
    # Convert the allowed string into a set for faster lookup
    allowed_set = set(allowed)
    
    # Initialize the counter for consistent strings
    count = 0
    
    # Iterate through each string in the list
    for string in strings:
        # Check if all characters in the string are in the allowed set
        if all(char in allowed_set for char in string):
            count += 1
            
    return count

# Test the function
assert count_consistent_strings(["ad", "bd", "aaab", "baa", "badab"], "ab") == 2
assert count_consistent_strings(["a", "b", "c", "ab", "ac", "bc", "abc"], "abc") == 7
assert count_consistent_strings(["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"], "cad") == 4

