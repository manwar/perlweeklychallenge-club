#!/usr/local/bin/python3

# You are given an array of strings and a check string.
# Write a script to find out if the check string is the acronym of the words in the given array.

def check_acronym (acronym, words):
    real_acronym = ''
    for word in words:
        real_acronym += word[0]
    print(acronym.upper() == real_acronym.upper())

# Example 1
words = ("Perl", "Python", "Pascal")
acronym = "ppp"
check_acronym(acronym, words)
    
# Example 2
words = ("Perl", "Raku")
acronym = "rp"
check_acronym(acronym, words)

# Example 3
words = ("Oracle", "Awk", "C")
acronym = "oac"
check_acronym(acronym, words)


