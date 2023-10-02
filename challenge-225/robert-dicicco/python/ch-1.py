#!/usr/bin/env python
# -----------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-07-10
# Challenge 225 Task 1 Max Words ( Python )
# -----------------------------------
lists = [["Perl and Raku belong to the same family.",
                "I love Perl.",
                "The Perl and Raku Conference."],
                ["The Weekly Challenge.",
                "Python is the most popular guest language.",
                "Team PWC has over 300 members."]]

max_num = 0
for lst in lists:
    print("Input: @list = ",lst)
    cnt = 0
    sz = len(lst)
    while cnt < sz:
        words = lst[cnt].split()
        num = len(words)
        if num > max_num:
            max_num = num
        cnt += 1
    print(f"Output: {max_num}\n")
    max_num = 0

#-----------------------------------
# SAMPLE OUTPUT
# python .\MaxWords.py

# Input: @list =  ['Perl and Raku belong to the same family.', 'I love Perl.', 'The Perl and Raku Conference.']
# Output: 8

# Input: @list =  ['The Weekly Challenge.', 'Python is the most popular guest language.', 'Team PWC has over 300 members.']
# Output: 7
#-----------------------------------


