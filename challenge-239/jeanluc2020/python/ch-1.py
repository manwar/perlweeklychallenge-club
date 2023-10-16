#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-239/#TASK1
#
# Task 1: Same String
# ===================
#
# You are given two arrays of strings.
#
# Write a script to find out if the word created by concatenating the array
# elements is the same.
#
## Example 1
##
## Input: @arr1 = ("ab", "c")
##        @arr2 = ("a", "bc")
## Output: true
##
## Using @arr1, word1 => "ab" . "c" => "abc"
## Using @arr2, word2 => "a" . "bc" => "abc"
#
## Example 2
##
## Input: @arr1 = ("ab", "c")
##        @arr2 = ("ac", "b")
## Output: false
##
## Using @arr1, word1 => "ab" . "c" => "abc"
## Using @arr2, word2 => "ac" . "b" => "acb"
#
## Example 3
##
## Input: @arr1 = ("ab", "cd", "e")
##        @arr2 = ("abcde")
## Output: true
##
## Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
## Using @arr2, word2 => "abcde"
#
############################################################
##
## discussion
##
############################################################
#
# This one is simple, just compare the strings after putting them
# together from the arrays' content.
#


def same_string(arr1: list, arr2: list):
    print("Input: (\"", "\", \"".join(arr1), "\"), (\"", "\", \"".join(arr2), "\")", sep='')
    if "".join(arr1) == "".join(arr2):
        print("Output: true")
    else:
        print("Output: false")


same_string( [ "ab", "c" ], ["a", "bc"])
same_string( [ "ab", "c" ], ["ac", "b"])
same_string( [ "ab", "cd", "e" ], [ "abcde" ])

