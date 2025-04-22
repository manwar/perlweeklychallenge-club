#!/usr/bin/env python3


def acronyms(words, word):
    """ Given an array of words and a word, return true if concatenating the
    first letter of each word in the given array matches the given word, return
    false otherwise.

    >>> acronyms(["Perl", "Weekly", "Challenge"], "PWC")
    True
    >>> acronyms(["Bob", "Charlie", "Joe"], "BCJ")
    True
    >>> acronyms(["Morning", "Good"], "MM")
    False
    """
    return word == "".join(w[0] for w in words)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
