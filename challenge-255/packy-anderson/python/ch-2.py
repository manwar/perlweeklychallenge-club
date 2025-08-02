#!/usr/bin/env python

import re
from collections import Counter

def frequentWord(p, w):
    # first, remove punctuation from the paragraph
    # (but we'll leave apostrophes for contractions)
    p = re.sub(r'[^a-z\'\s]', '', p.lower())

    # count the words in $paragraph
    count = Counter()
    for pw in p.split():
        count[pw] += 1

    # generate the output about the banned word
    bannedCount = count[w] if w in count else 0
    output = f'The banned word "{w}" occurs {bannedCount} ';
    output += 'time' if bannedCount == 1 else 'times'
    output += ".\n"

    # delete the banned word from the word count
    del count[w]

    # now find the most frequent word left and report on that
    decorated = [ ( count[w], w ) for w in count.keys() ]
    sorted_tuples = sorted(
        decorated,
        # the - before the first element sorts descending
        key=lambda k: -k[0]
    )
    freqWord = sorted_tuples[0][1]
    freqCount = count[freqWord]

    output +=  f'The other word "{freqWord}" '
    output += f'occurs {freqCount} '
    output += 'time.' if freqCount == 1 else 'times.'

    return (freqWord, output)

def solution(p, w):
    print(f'Input: $p = "{p}"')
    print(f'       $w = "{w}"')
    (freqWord, output) = frequentWord(p, w)
    print(f'Output: "{freqWord}"')
    print('')
    print(output)

print('Example 1:')
solution(
  "Joe hit a ball, the hit ball flew far after it was hit.",
  "hit"
)

print('\nExample 2:')
solution(
  "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
  "the"
)