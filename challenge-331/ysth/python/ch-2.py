import sys
import regex
from itertools import batched

def buddy_strings(string1: str, string2: str) -> bool:
    return True if regex.fullmatch(regex.escape(string1)+'{1<=s<=1}', string2) else False

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    for string1, string2 in batched(inputs, 2):
        print(f'{string1:<30}\n{string2:<30}\n   -> {"yes" if buddy_strings(string1, string2) else "no"}')

if __name__ == '__main__':
    main()
