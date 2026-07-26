#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge" ""

import sys


def similar_list(list1: list[str], list2: list[str], list3: list[list[str]]) -> bool:
    # Return false if the list1 and list2 are different length
    if len(list1) != len(list2):
        return False

    # ... or they are the same
    if list1 == list2:
        return True

    # Create mapping hash to map words to their target word
    mapping = {}
    for mapping_list in list3:
        target_word = mapping_list.pop()
        for word in mapping_list:
            mapping[word] = target_word

    # Convert the first two list and check for equality
    target_list1 = [mapping.get(word, word) for word in list1]
    target_list2 = [mapping.get(word, word) for word in list2]
    return target_list1 == target_list2


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into list of words, separated by commas
    list_of_words = [s.split(",") for s in sys.argv[1:]]

    # Call the code and return the result
    result = similar_list(list_of_words[0], list_of_words[1], list_of_words[2:])
    print("true" if result else "false")


# Call main if run from the command line
if __name__ == "__main__":
    main()
