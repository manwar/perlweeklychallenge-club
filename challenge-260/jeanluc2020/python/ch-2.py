#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/#TASK2
#
# Task 2: Dictionary Rank
# =======================
#
# You are given a word, $word.
#
# Write a script to compute the dictionary rank of the given word.
#
## Example 1
##
## Input: $word = 'CAT'
## Output: 3
##
## All possible combinations of the letters:
## CAT, CTA, ATC, TCA, ACT, TAC
##
## Arrange them in alphabetical order:
## ACT, ATC, CAT, CTA, TAC, TCA
##
## CAT is the 3rd in the list.
## Therefore the dictionary rank of CAT is 3.
#
## Example 2
##
## Input: $word = 'GOOGLE'
## Output: 88
#
## Example 3
##
## Input: $word = 'SECRET'
## Output: 255
#
############################################################
##
## discussion
##
############################################################
#
# We first create all possible permutations, for which we use an
# iterator-based solution from Algorithm::Permute. Then we keep
# all permutations, removing duplicates (Algorithm::Permute will
# for example generate the word "GOOGLE" twice, once for each "O"
# in the first and the second of two possible positions). Then we
# just walk the sorted list, counting the index while walking, and
# returning 1+index once we found the original word.

import itertools

def dictionary_rank (word: str) -> None:
    chars = list(word)
    print(f"Input: {word}")
    permutations = list(itertools.permutations(chars))
    unique_permutations: list = []
    seen: dict = {}
    for perm in permutations:
        w = "".join(perm)
        if w not in seen:
            unique_permutations.append(w)
            seen[w] = 1
    sorted_array = sorted(unique_permutations)
    i=0
    while i < len(sorted_array):
        if sorted_array[i] == word:
            i += 1
            print(f"Output: {i}")
            return
        i += 1

dictionary_rank('CAT');
dictionary_rank('GOOGLE');
dictionary_rank('SECRET');

