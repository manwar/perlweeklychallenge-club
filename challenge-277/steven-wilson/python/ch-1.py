#!/usr/bin/env python3

from collections import Counter


def count_common(words1, words2):
    """ Given  two array of strings, return the count of words that appears in
    both arrays exactly once.

    >>> count_common(("Perl", "is", "my", "friend"), ("Perl", "and", "Raku", "are", "friend"))
    2
    >>> count_common(("Perl", "and", "Python", "are", "very", "similar"), ("Python", "is", "top", "in", "guest", "languages"))
    1
    >>> count_common(("Perl", "is", "imperative", "Lisp", "is", "functional"), ("Crystal", "is", "similar", "to", "Ruby"))
    0
    """
    c1 = Counter(words1)
    c2 = Counter(words2)
    return len({k for k, v in c1.items() if v == 1} &
               {k for k, v in c2.items() if v == 1})


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
