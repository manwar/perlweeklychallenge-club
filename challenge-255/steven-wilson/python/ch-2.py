#!/usr/bin/env python3

from collections import Counter
import string


def most_frequent_word(paragraph, banned):
    '''Given a paragraph and a banned word. Return the most frequent word that
    is not banned
    >>> most_frequent_word(
    ...     "Joe hit a ball, the hit ball flew far after it was hit.", "hit")
    'ball'
    >>> most_frequent_word(
    ...     "Perl and Raku belong to the same family. "
    ...     "Perl is the most popular language in the weekly challenge.", "the")
    'Perl'
    '''
    if not paragraph or not banned:
        raise ValueError("Both strings must be non-empty.")

    paragraph_no_punctuation = paragraph.translate(
        str.maketrans("", "", string.punctuation))
    paragraph_counter = Counter(paragraph_no_punctuation.split())

    if banned in paragraph_counter:
        del paragraph_counter[banned]

    if not paragraph_counter:
        raise ValueError("No words found in the paragraph after removing punctuation and banned word.")

    return paragraph_counter.most_common()[0][0]


if __name__ == "__main__":
    import doctest

    doctest.testmod()
