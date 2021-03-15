'''

TASK #1 › Pattern Match
Submitted by: Mohammad S Anwar
You are given a string $S and a pattern $P.

Write a script to check if given pattern validate the entire string. Print 1 if pass otherwise 0.

The patterns can also have the following characters:

? - Match any single character.
* - Match any sequence of characters.
    Example 1:
        Input: $S = "abcde" $P = "a*e"
        Output: 1
    Example 2:
        Input: $S = "abcde" $P = "a*d"
        Output: 0
    Example 3:
        Input: $S = "abcde" $P = "?b*d"
        Output: 0
    Example 4:
        Input: $S = "abcde" $P = "a*c?e"
        Output: 1

'''
import re

#Input
S = "abcde";
P = "a*c?e";

pattern = P.replace('*' , '.+').replace('?' , '.')
pattern = "^" + pattern + "$"

if re.match(pattern, S):
    print (1)
else:
    print (0)
