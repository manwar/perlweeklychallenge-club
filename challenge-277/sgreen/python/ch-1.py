#!/usr/bin/env python3

from collections import Counter
import sys


def count_common(*words_list: list[list]) -> int:
    count = 0

    # Take a list of unique words in the first list
    for word in set(words_list[0]):
        # Check that it occurs once in each list
        for words in words_list:
            if words.count(word) != 1:
                # It doesn't, go to the next word.
                break
        else:
            # It does, add to the count
            count+=1

    # Count the number of words that appear in all lists
    return count

def main():
    # Convert two space-separated strings into muliple lists
    word_list = (words.split(' ')for words in sys.argv[1:])
    result = count_common(*word_list)
    print(result)


if __name__ == '__main__':
    main()
