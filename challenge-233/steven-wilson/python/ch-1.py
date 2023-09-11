#!/usr/bin/env python3


def similarWords(*elements):
    """Return count of similar words. Two words are similar if they
    consist of the same characters.
    >>> similarWords( "aba", "aabb", "abcd", "bac", "aabc" )
    2
    >>> similarWords( "aabb", "ab", "ba" )
    3
    >>> similarWords( "nba", "cba", "dba" )
    0
    """
    count = 0
    for i in range(len(elements) - 1):
        elem = elements[i]
        for j in range(i + 1, len(elements)):
            elemNext = elements[j]
            if compWords(elem, elemNext):
                count += 1
    return count


def compWords(word1, word2):
    """Return true if two words have same characters
    >>> compWords("aba", "aabb")
    True
    >>> compWords("abc", "aabb")
    False
    """
    word1s = set([*word1])
    word2s = set([*word2])
    return len(word1s) == len(word2s) and len(word1s.difference(word2s)) == 0


if __name__ == "__main__":
    import doctest

    doctest.testmod()
    