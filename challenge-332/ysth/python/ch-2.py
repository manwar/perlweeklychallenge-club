import sys
import regex

def odd_letters(string: str) -> bool:
    return not regex.search(r'(\pL)(?<!\1\1)(?:\1\1)*+(?=\1)', ''.join(sorted(string)))

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    for string in inputs:
        print(f'{string:<30} -> {odd_letters(string)}')

if __name__ == '__main__':
    main()
