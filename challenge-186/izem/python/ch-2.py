"""Perl weekly challenge 186 - Task 2: Unicode Makeover.

https://theweeklychallenge.org/blog/perl-weekly-challenge-186/

Depends on package Unidecode. Please install by:
  `pip install Unidecode`
"""
from unidecode import unidecode


def makeover(characters: str) -> str:
    """Replace the unicode characters with ascii equivalent."""
    return unidecode(characters)


if __name__ == '__main__':
    examples = ['ÃÊÍÒÙ', 'âÊíÒÙ']
    for example in examples:
        print(f"'{example}' => '{makeover(example)}'")
