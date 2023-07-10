#!/usr/bin/env python
# -*- coding: utf-8 -*-


def max_words(lst):
    return max(len(sentence.split()) for sentence in lst)


# testing
list = [
    "Perl and Raku belong to the same family.",
    "I love Perl.",
    "The Perl and Raku Conference.",
]

print(max_words(list))  # should print 8
