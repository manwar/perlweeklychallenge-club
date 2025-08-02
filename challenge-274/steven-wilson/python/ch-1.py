#!/usr/bin/env python3

VOWELS = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}


def goat_latin(sentence):
    ''' Given a sentence, convert the given sentence to Goat Latin, a made up
    language similar to Pig Latin.

    Rules for Goat Latin:

    1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
       "ma" to the end of the word.
    2) If a word begins with consonant i.e. not a vowel, remove first
       letter and append it to the end then add "ma".
    3) Add letter "a" to the end of first word in the sentence, "aa" to
       the second word, etc etc.

    >>> goat_latin("I love Perl")
    'Imaa ovelmaaa erlPmaaaa'
    >>> goat_latin("Perl and Raku are friends")
    'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa'
    >>> goat_latin("The Weekly Challenge")
    'heTmaa eeklyWmaaa hallengeCmaaaa'
    '''
    words = []
    for number, word in enumerate(sentence.split(" "), start=1):
        words.append(convert_word(word, number))
    return " ".join(words)



def convert_word(word, number):
    '''
    >>> convert_word("I", 1)
    'Imaa'
    >>> convert_word("Perl", 1)
    'erlPmaa'
    >>> convert_word("are", 4)
    'aremaaaaa'
    '''
    if word[0] in VOWELS:
        return word + 'ma' + number * 'a'
    return word[1:] + word[0] + 'ma' + number * 'a'


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
