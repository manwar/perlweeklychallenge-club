# Task 2: Reverse Letters
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string.
# Write a script to reverse only the alphabetic characters in the string.
# 
# Example 1
# Input: $str = "p-er?l"
# Output: "l-re?p"
#
# Example 2
# Input: $str = "wee-k!L-y"
# Output: "yLk-e!e-w"
#
# Example 3
# Input: $str = "_c-!h_all-en!g_e"
# Output: "_e-!g_nel-la!h_c"

def reverse_only_characters(str):
    old_str = [c for c in str[::-1] if c.isalpha()]

    new_string = ""
    for i in range(len(str)):
        if str[i].isalpha():
            c = old_str.pop(0)
            new_string += c
        else:
            new_string += str[i]

    print("'%s' -> '%s'" % (str, new_string) )

if __name__ == "__main__":
    str = "p-er?l"
    reverse_only_characters(str)

    str = "wee-k!L-y"
    reverse_only_characters(str)

    str = "_c-!h_all-en!g_e"
    reverse_only_characters(str)
