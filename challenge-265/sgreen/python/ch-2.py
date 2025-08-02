#!/usr/bin/env python3

from collections import Counter
import re
import sys


def completing_word(s: str, str_list: list) -> str | None:
    """_summary_

    Args:
        s (str): _description_
        str_list (list): _description_

    Returns:
        str|None: _description_
    """
    # Calculate the frequency of letters in the string after converting to lower
    #  case and remove non ASCII characters
    freq = Counter(re.sub('[^a-z]', '', s.lower()))

    # Sort the list by length (shortest first)
    str_list.sort(key=len)

    for word in str_list:
        # Calculate the frequency of letters in this word
        word_freq = Counter(word.lower())

        for letter, count in freq.items():
            # Check that this letter appear in word at least count times
            if word_freq.get(letter, 0) < count:
                break
        else:
            # We have a solution
            return word

    return None


def main():
    result = completing_word(sys.argv[1], sys.argv[2:])
    if result:
        print(result)
    else:
        print('No solution found!')


if __name__ == '__main__':
    main()
