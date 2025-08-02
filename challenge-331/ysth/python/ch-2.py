import sys
import regex
from itertools import batched

def buddy_strings(string1: str, string2: str) -> bool:
    if len(string1) != len(string2):
        return False
    swaps = 0
    pair_exists: bool = False
    previous_character1: str
    previous_character2: str
    for i in range(len(string1)):
        character1: str = string1[i]
        character2: str = string2[i]
        if swaps == 1:
            # second character of swap
            if previous_character2 != character1 or character2 != previous_character1:
                return False
            swaps = 2
        elif string1[i] != string2[i]:
            # starting the first swap
            if swaps > 0:
                return False
            previous_character1 = character1
            previous_character2 = character2
            swaps = 1
        pair_exists = pair_exists or i > 0 and string1[i-1] == string1[i]

    return pair_exists and swaps == 0 or swaps == 2

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    for string1, string2 in batched(inputs, 2):
        print(f'{string1:<30}\n{string2:<30}\n   -> {"yes" if buddy_strings(string1, string2) else "no"}')

if __name__ == '__main__':
    main()
