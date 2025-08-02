#!/usr/bin/env python3

from collections import Counter


def uncommon_words(*sentences):
    ''' Given  two sentences, find all uncommmon words in any order in the
    given two sentences. Return ('') if none found.  A word is uncommon if it
    appears exactly once in one of the sentences and doesn’t appear in other
    sentence.

    >>> uncommon_words('Mango is sweet', 'Mango is sour')
    ['sweet', 'sour']
    >>> uncommon_words('Mango Mango', 'Orange')
    ['Orange']
    >>> uncommon_words('Mango is Mango', 'Orange is Orange')
    ['']
    '''
    if not sentences:
        raise TypeError('Provide at least one sentence.')

    counter = Counter(word for sentence in sentences for word in sentence.split())
    uncommon = [word for word, count in counter.items() if count == 1]
    return uncommon if uncommon else ['']


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
