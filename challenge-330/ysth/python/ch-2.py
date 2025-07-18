import sys
import grapheme

def grapheme_length_more_than_2(string: str) -> bool:
    return grapheme.length(string, 3) > 2

def title_capital(string: str) -> str:
    return ' '.join( word.capitalize() if grapheme_length_more_than_2(word) else word.lower() for word in string.split(' ') )

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    for string in inputs:
        print(f'{string:<30} -> {title_capital(string)}')

if __name__ == '__main__':
    main()
