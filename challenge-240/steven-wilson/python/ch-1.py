#!/usr/bin/env python3


def acronym(check, words):
    '''
    Is the check string an acronym of the words in the given array
    >>> acronym("ppp", ("Perl", "Python", "Pascal"))
    True
    >>> acronym("rp", ("Perl", "Raku"))
    False
    >>> acronym("oac", ("Oracle", "Awk", "C"))
    True
    '''
    acronym = "".join([word[0].lower() for word in words])
    if acronym == check:
        return True
    else:
        return False


if __name__ == "__main__":
    import doctest

    doctest.testmod()
