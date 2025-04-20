#!/usr/bin/env python3

from collections import Counter
import sys


def friendly_strings(str1: str, str2: str) -> bool:
    # Check strings are the same length
    if len(str1) != len(str2):
        return False

    if str1 == str2:
        # We can still swap two characters if there are any letters that
        #  appear two or more times
        freq = Counter(str1)
        return any(i for i in freq.values() if i > 1)

    # Find characters that are different
    differences = [ i for i in range(len(str1)) if str1[i] != str2[i]]

    if len(differences) == 2:
        # Check that the letters at each position were switched
        pos1, pos2 = differences
        if str1[pos1] == str2[pos2] and str2[pos1] == str1[pos2]:
            return True

    return False



def main():
    result = friendly_strings(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
