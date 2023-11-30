#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK1
#
# Task 1: Sort Language
# =====================
#
# You are given two array of languages and its popularity.
#
# Write a script to sort the language based on popularity.
# Example 1
#
# Input: @lang = ('perl', 'c', 'python')
#        @popularity = (2, 1, 3)
# Output: ('c', 'perl', 'python')
#
# Example 2
#
# Input: @lang = ('c++', 'haskell', 'java')
#        @popularity = (1, 3, 2)
# Output: ('c++', 'java', 'haskell')
#
############################################################
##
## discussion
##
############################################################
#
# The solution that jumps right into my face is to fill the data
# into a hash table, using lang as the key and popularity as the
# value. Then sort the keys by their values and put the result into
# the output.

def sort_language(lang: list, popularity: list):
    print("Input: (", ", ".join(str(x) for x in lang), "), (", ", ".join(str(x) for x in popularity), ")")
    hash = {}
    for i in range(len(lang)):
        hash[lang[i]] = popularity[i]
    print("Output: (", ", ".join(str(x) for x in sorted(hash, key=hash.get)), ")")

sort_language( ['perl', 'c', 'python'], [2, 1, 3] );
sort_language( ['c++', 'haskell', 'java'], [1, 3, 2] );

