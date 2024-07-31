#!/usr/bin/env python3


def reverse_word(word, char):
    """ Given a word and a character, replace the substring up to and including
    the character with its characters sorted alphabetically. If the character
    doesn’t exist then DON'T do anything.

    >>> reverse_word("challenge", "e")
    'acehllnge'
    >>> reverse_word("programming", "a")
    'agoprrmming'
    >>> reverse_word("champion", "b")
    'champion'
    >>> reverse_word("champion", "n")
    'achimnop'
    """
    position = word.find(char)

    if position == -1:
        return word

    return "".join(sorted(word[:position+1])) + word[position+1:]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
