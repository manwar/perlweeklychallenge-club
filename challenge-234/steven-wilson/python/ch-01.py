#!/usr/bin/env python3

from collections import Counter


def common_characters(*words):
    """return all alphabetic characters that show up in all words 
    including duplicates
    >>> common_characters("java", "javascript", "julia")
    ('j', 'a')
    >>> common_characters("bella", "label", "roller")
    ('e', 'l', 'l')
    >>> common_characters("cool", "lock", "cook")
    ('c', 'o')
    """
    words = list(words)
    common = list(words.pop(0))
    count_common = Counter(common)

    for word in words:
        count_char = Counter(word)
        common_copy = common.copy()
        for char in common_copy:
            if char not in word:
                common.remove(char)
            elif count_common[char] > count_char[char]:
                count_common[char] -= 1
                common.reverse()
                common.remove(char)
                common.reverse()

    return tuple(common)



if __name__ == "__main__":
    import doctest

    doctest.testmod()
