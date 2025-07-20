import sys
import regex

def clear_digits(string: str) -> str:
    return regex.sub(r'[0-9]*(?<pair>[a-z](?&pair)?[0-9])*', '', string)

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    for string in inputs:
        print(f'{string:<30} -> {clear_digits(string)}')

if __name__ == '__main__':
    main()
