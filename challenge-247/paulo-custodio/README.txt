Perl Weekly Challenge 247
https://theweeklychallenge.org/blog/perl-weekly-challenge-247/

Task 1: Secret Santa
Submitted by: Andreas Voegele
Secret Santa is a Christmas tradition in which members of a group are randomly assigned a person to whom they give a gift.

You are given a list of names. Write a script that tries to team persons from different families.

Example 1
The givers are randomly chosen but don't share family names with the receivers.

Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                 'Mrs. Anwar',
                 'Mr. Conway',
                 'Mr. Cross',
                );

Output:

    Mr. Conway -> Mr. Wall
    Mr. Anwar -> Mrs. Wall
    Mrs. Wall -> Mr. Anwar
    Mr. Cross -> Mrs. Anwar
    Mr. Wall -> Mr. Conway
    Mrs. Anwar -> Mr. Cross

Example 2
One gift is given to a family member.

Input: @names = ('Mr. Wall',
                 'Mrs. Wall',
                 'Mr. Anwar',
                );

Output:

    Mr. Anwar -> Mr. Wall
    Mr. Wall -> Mrs. Wall
    Mrs. Wall -> Mr. Anwar


Task 2: Most Frequent Letter Pair
Submitted by: Jorg Sommrey
You are given a string S of lower case letters 'a'..'z'.

Write a script that finds the pair of consecutive letters in S that appears most frequently. If there is more than one such pair, chose the one that is the lexicographically first.

Example 1
Input: $s = 'abcdbca'
Output: 'bc'

'bc' appears twice in `$s`

Example 2
Input: $s = 'cdeabeabfcdfabgcd'
Output: 'ab'

'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically smaller than 'cd'.
