import sys
import grapheme
import regex

def last_word_length(string: str) -> str:
    return grapheme.length(regex.sub(r'^.*[^\pL\pN\pM\p{pC}](?=[\pL\pN\pM\p{pC}])|(?<=[\pL\pN\pM\p{pC}])[^\pL\pN\pM\p{pC}].*', '', string))

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    for string in inputs:
        print(f'{string:<30} -> {last_word_length(string)}')

if __name__ == '__main__':
    main()
