#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge 081
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-081/
#               Task 2 - Frequency Sort
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 10/09/2020 10:43:10 AM
#===============================================================================
"""
import re


def frequency_sort(arg):
    """ Do the frequency sorting """

    # sanitize the input as per the challenge
    arg = re.sub(r'[."\(\),]', ' ', arg)
    arg = re.sub(r'(?:\'s)', ' ', arg)
    arg = re.sub(r'(?:--)', ' ', arg)

    count = {}
    # I'm sure it can be done in one-liner with map, but I took the longer approach
    # First split the array and create hash of counts of each word
    for item in re.split(r'\s+', arg):
        if not item:
            continue
        try:
            count[item] += 1
        except KeyError:
            count[item] = 1

    rev_count = {}
    # create reverse hash with counts as key and the words as array
    for key in count.keys():
        try:
            rev_count[count[key]].append(key)
        except KeyError:
            rev_count[count[key]] = [key]

    result = []
    for key in rev_count.keys():
        # sort the arrays and put them to the result output
        result.append(str(key)+' '+' '.join(sorted(rev_count[key])))

    return sorted(result)


assert frequency_sort("West Side Story The award-winning adaptation of the classic romantic tragedy \"Romeo and Juliet\". The feuding families become two warring New York City gangs, the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their hatred escalates to a point where neither can coexist with any form of understanding. But when Riff's best friend (and former Jet) Tony and Bernardo's younger sister Maria meet at a dance, no one can do anything to stop their love. Maria and Tony begin meeting in secret, planning to run away. Then the Sharks and Jets plan a rumble under the highway--whoever wins gains control of the streets. Maria sends Tony to stop it, hoping it can end the violence. It goes terribly wrong, and before the lovers know what's happened, tragedy strikes and doesn't stop until the climactic and heartbreaking ending.") == ["1 But City It Jet Juliet Latino New Romeo Side Story Their Then West York adaptation any anything at award-winning away become before begin best classic climactic coexist control dance do doesn't end ending escalates families feuding form former friend gains gangs goes happened hatred heartbreaking highway hoping in know love lovers meet meeting neither no one plan planning point romantic rumble run secret sends sister streets strikes terribly their two under understanding until violence warring what when where white whoever wins with wrong younger", '2 Bernardo Jets Riff Sharks The by it led tragedy', '3 Maria Tony a can of stop', '4 to', '9 and the']
