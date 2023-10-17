#!/usr/local/bin/python3

# Task 2: Consistent Strings
# You are given an array of strings and allowed string having distinct characters.
# A string is consistent if all characters in the string appear in the string allowed.

def check_allowed(allowed, str_list):
    success_count = 0
    # check each set of letters in the str list
    for letters in str_list:
        # if a letter doesn't match exit loop otherwise continue.
        for i, char in enumerate(letters):
            if char in allowed:
                if i == (len(letters)-1): # if last then increment success
                    success_count += 1
                continue
            else:
                break # exit letters loop if one letter doesn't match
    print(success_count)

# Example 1
str_list = ["ad", "bd", "aaab", "baa", "badab"]
allowed = "ab"
check_allowed(allowed, str_list)

# Example 2
str_list = ["a", "b", "c", "ab", "ac", "bc", "abc"]
allowed = "abc"
check_allowed(allowed, str_list)

# Example 3
str_list = ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]
allowed = "cad"
check_allowed(allowed, str_list)
