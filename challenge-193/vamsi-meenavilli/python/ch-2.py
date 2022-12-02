"""
 Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-193

    Task 2: Odd String
    Submitted by: Mohammad S Anwar
    You are given a list of strings of same length, @s.

    Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

    Find the difference array for each string as shown in the example. Then pick the odd one out.
"""

def oddString(strings_list):
    strings_list_diff_map = {}

    for i in strings_list:
        diff = ','.join([str(ord(i[j + 1]) - ord(i[j])) for j in range(len(i) - 1)])

        if diff in strings_list_diff_map:
            strings_list_diff_map[diff].append(i)
        else:
            strings_list_diff_map[diff] = [i]

    for i in strings_list_diff_map:
        if len(strings_list_diff_map[i]) == 1:
            return strings_list_diff_map[i][0]

def oddStringTest():
    assert oddString(["adc", "wzy", "abc"]) == "abc", 'Example 1 Failed'
    assert oddString(["aaa", "bob", "ccc", "ddd"]) == "bob", 'Example 2 Failed'

oddStringTest()





