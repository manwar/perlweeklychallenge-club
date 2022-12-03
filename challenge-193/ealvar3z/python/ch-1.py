#!/usr/bin/env python3


def bit_str(n):
    limit = 1 << n
    for i in range(limit):
        value = i
        width = f'0{n}'
        print(f'{value:{width}b}')


if __name__ == "__main__":
    bit_str(2)
    print('\n')
    bit_str(3)
