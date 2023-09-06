#!/usr/bin/env python

def charsInWord(word):
    # split the word into characters, use set() to get
    # the unique values and then rejoin as a string
    return ''.join(set(list(word)))

def findSimilarWordPairs(words):
    similar = {}
    for word in words:
        charset = charsInWord(word)
        if charset not in similar:
            similar[charset] = []
        similar[charset].append(word)

    # filter out character sets that only have one word
    multiples = filter(
        lambda k: len(similar[k]) > 1,
        similar.keys()
    )

    # make pairs by looping over the list
    # of letter sets that had multiple entries
    pairs = []
    for charset in multiples:
        while ( len(similar[charset]) >= 2 ):
            # remove the first word from the list of words
            first = similar[charset].pop(0)
            # pair it with each of the remaining words
            for second in similar[charset]:
                pairs.append([ first, second ])

    return pairs

def solution(words):
    quoted = '"' + '", "'.join(words) + '"'
    print(f'Input: @words = ({quoted})')
    pairs = findSimilarWordPairs(words)

    print(f'Output: {len(pairs)}')
    count = 0
    for pair in pairs:
        if count == 0:
            print('')
        count += 1
        quoted = '"' + '", "'.join(pair) + '"'
        print(f'Pair {count}: similar words ({quoted})')

print("Example 1:")
solution(["aba", "aabb", "abcd", "bac", "aabc"])

print("\nExample 2:")
solution(["aabb", "ab", "ba"])

print("\nExample 3:")
solution(["nba", "cba", "dba"])