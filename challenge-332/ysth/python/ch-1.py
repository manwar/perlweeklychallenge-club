import sys

def binary_date(date: str) -> str:
    return '-'.join(bin(int(i))[2:] for i in date.split('-'))

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    for string in inputs:
        print(f'{string:<30} -> {binary_date(string)}')

if __name__ == '__main__':
    main()
