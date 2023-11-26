#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-240/#TASK1
#
# Task 1: Acronym
# ===============
#
# You are given an array of strings and a check string.
#
# Write a script to find out if the check string is the acronym of the words in
# the given array.
#
## Example 1
##
## Input: @str = ("Perl", "Python", "Pascal")
##        $chk = "ppp"
## Output: true
#
## Example 2
##
## Input: @str = ("Perl", "Raku")
##        $chk = "rp"
## Output: false
#
## Example 3
##
## Input: @str = ("Oracle", "Awk", "C")
##        $chk = "oac"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# This one is straight forward:
# - get the first character of each string in the array
# - lowercase it
# - join all of these together into a string
# - compare that string to $chk

def acronym(str: list, chk: str):
    print("Input: (" + ', '.join(x for x in str) + "), \"", chk, "\"", sep='')
    tmp: str = ""
    for x in str:
        tmp += x[0].lower()
    if tmp == chk:
        print("Output: true")
    else:
        print("Output: false")


acronym( ["Perl", "Python", "Pascal"], "ppp");
acronym( ["Perl", "Raku"], "rp");
acronym( ["Oracle", "Awk", "C"], "oac");

