#!/usr/bin/env python

# https://docs.python.org/3/library/collections.html#counter-objects
from collections import Counter

from num2words import num2words

def conjunction(words):
    if len(words) < 2:
        return(words)
    elif len(words) == 2:
        return(f'{words[0]} and {words[1]}')
    else:
        last = words.pop(-1)
        l = ', '.join(words)
        return(f'{l}, and {last}')

def pairCount(s):
    # instantiate a counter object
    count = Counter()
    while (len(s) > 1):
        pair = s[0:2]    # the first two characters
        count[pair] += 1 # count the pair
        s = s[1:]        # remove the first character
    # convert it back to a dict now that we're done counting
    return dict(count)

def mostFrequentPair(s):
    # count the letter pairs
    pairs = pairCount(s)

    # sort the pairs by their counts
    # use the Decorate-Sort-Undecorate idiom
    # to convert the dict into a list
    # https://docs.python.org/3/howto/sorting.html#decorate-sort-undecorate
    decorated = [ (pairs[p], p) for p in pairs.keys() ]
    sorted_tuples = sorted(
        decorated,
        # the - before the first element sorts descending
        key=lambda k: (-k[0], k[1])
    )
    sorted_pairs = [ t[1] for t in sorted_tuples ]

    max_pair = []
    # pull off first value from the sorted pairs
    max_pair.append( sorted_pairs.pop(0) )
    # get it's count
    max_count = pairs[ max_pair[0] ]

    while pairs[ sorted_pairs[0] ] == max_count:
        # there are pairs on the sorted list that have the
        # same count, so let's put them on the list, too
        max_pair.append( sorted_pairs.pop(0) )

    # set aside the pair that sorted to the top
    first_pair = max_pair[0]

    # make the count an english word
    count = (
        'once'  if (max_count == 1) else # 🎶
        'twice' if (max_count == 2) else # 🎶
        num2words(max_count) + ' times'  # a lady 🎶
    )

    # and format the explanation
    if len(max_pair) == 1:
        explain = f"'{first_pair}' appears {count} in \$s"
    else:
        # quote all the pairs
        max_pair = [ f"'{x}'" for x in max_pair]
        explain = f"{conjunction(max_pair)} appear {count} in "
        explain += f"$s and '{first_pair}' is "
        explain += "lexicographically smallest."

    return first_pair, explain

def solution(s):
    print(f"Input: @s = '{s}'")
    (pair, explain) = mostFrequentPair(s)
    print(f"Output: '{pair}'\n")
    print(explain)

print('Example 1:')
solution('abcdbca')

print('\nExample 2:')
solution('cdeabeabfcdfabgcd')

print('\nExample 3:')
solution('abcdeabcde')