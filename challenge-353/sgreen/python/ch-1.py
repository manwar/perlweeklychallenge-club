#!/usr/bin/env python3

import sys


def max_words(sentences: list) -> int:
    """Returns the maximum number of words in any sentence from the input list.

    Args:
        sentences (list): A list of sentences (strings).

    Returns:
        int: The maximum number of words found in any sentence.
    """
    max_words = 0

    # Iterate through each sentence
    for sentence in sentences:
        # Count words in the sentence, update max_words if necessary
        word_count = len(sentence.strip().split())
        if word_count > max_words:
            max_words = word_count

    # Return the maximum word count found
    return max_words


def main():
    result = max_words(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
