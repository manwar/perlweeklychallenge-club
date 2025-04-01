
# Task 1: Equal Strings
# Submitted by: Mohammad Sajid Anwar
# 
# You are given three strings.
# You are allowed to remove the rightmost character of a string to make all equals.
# Write a script to return the number of operations to make it equal otherwise -1.
# 
# Example 1
# Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
# Output: 2
# 
# Operation 1: Delete "c" from the string "abc"
# Operation 2: Delete "b" from the string "abb"
# 
# Example 2
# Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
# Output: -1
# 
# Example 3
# Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
# Output: 3

def remove_rightmost_to_make_equals(s1, s2, s3):
    os1 = s1
    os2 = s2
    os3 = s3

    i = 0
    while (True):
        if s1 == s2 and s2 == s3\
           or\
           len(s1) == 0:
            if len(s1) == 0:
                i = -1
            break
        s1, s2, s3 = sorted((s1, s2, s3), reverse=True, key=len)
        s1 = s1[:-1]
        i += 1

    print("'%s' '%s' '%s' -> %d" %  
            (os1, os2, os3, i)
         )

if __name__ == "__main__":
    s1 = "abc"; s2 = "abb"; s3 = "ab"
    remove_rightmost_to_make_equals(s1, s2, s3)

    s1 = "ayz"; s2 = "cyz"; s3 = "xyz"
    remove_rightmost_to_make_equals(s1, s2, s3)

    s1 = "yza"; s2 = "yzb"; s3 = "yzc"
    remove_rightmost_to_make_equals(s1, s2, s3)
