#!/usr/bin/env python3


def find_anagrams(*words):
    """ Given a list of words, find any two consecutive words and if they are
    anagrams, drop the first word and keep the second. You continue this until
    there is no more anagrams in the given list and return the count of final
    list.
    >>> find_anagrams("acca", "dog", "god", "perl", "repl")
    3
    >>> find_anagrams("abba", "baba", "aabb", "ab", "ab")
    2
    """
    length_words = len(words)
    drop = 0

    if length_words < 2:
        raise ValueError("At least 2 arguments are required")

    for n, _ in enumerate(words):
        if n < length_words - 1 and are_anagrams(words[n], words[n+1]):
            drop += 1
    return length_words - drop


def are_anagrams(first, second):
    """ Are two words an anagram of each other
    >>> are_anagrams("dog", "god")
    True
    >>> are_anagrams("aabb", "ab")
    False
    """
    return sorted(first) == sorted(second)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
