#!/usr/bin/env python

from collections import Counter

def charFrequency(word):
    # https://docs.python.org/3/library/collections.html#counter-objects
    freq = Counter()
    for c in word:
        freq[c] += 1
    return freq

def commonCharacters(words):
    # get the character freqencies for each word
    freq = list(map(charFrequency, words))

    # grab the character frequency map for the first word
    first = freq.pop(0)

    # make a copy of the dictionary since we'll
    # be modifying it in the loop
    first_orig = dict(first)

    # now check the characters in the first word against
    # the characters in all the subsequent words
    for subsequent in freq:
        for c in first_orig:
            if c not in subsequent:
                # this character isn't in subsequent words,
                # so let's remove it from the frequency map
                # of the first word
                first.pop(c)
            else:
                # the character IS in subsequent words,
                # so let's set the frequency count to be
                # the minimum count found in those words
                first[c] = min(first[c], subsequent[c])

    # now we generate a list of characters in the order they
    # appear in the first word
    output = []
    # once again, loop over the characters in the first word
    for c in words[0]:
        if c not in first:
            continue
        if first[c] > 1:
            first[c] -= 1
        else:
            first.pop(c)
        output.append(c)
    return output

def solution(words):
    quoted = '"' + '", "'.join(words) + '"'
    print(f'Input: @words = ({quoted})')
    output = commonCharacters(words)
    quoted = '"' + '", "'.join(output) + '"'
    print(f'Output: ({quoted})')

print("Example 1:")
solution(["java", "javascript", "julia"])

print("\nExample 2:")
solution(["bella", "label", "roller"])

print("\nExample 3:")
solution(["cool", "lock", "cook"])