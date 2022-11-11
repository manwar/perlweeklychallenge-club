#!/usr/bin/env python3


if __name__ == "__main__":

    tests = ['Perl', 'TPF', 'PyThon', 'raku']

    for w in tests:
        match w:
            case w if not w.isupper() and not w.istitle() and not w.islower():
                print(f'Input: {w}')
                print('Output: 0')
            case _:
                print(f'Input: {w}')
                print('Output: 1')

