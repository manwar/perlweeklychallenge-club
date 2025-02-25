#!/usr/bin/python3

from itertools import permutations


def main():
    examples = [[20, 3], [3, 30, 34, 5, 9]]
    for e in examples:
        output = largest_number(e)
        print(f"    Input:  ints = {e}")
        print(f"    Output: {output}")
        print("")


def largest_number(array):
    p = permutations(array)
    l = 0
    for j in list(p):
        k = int("".join(str(x) for x in j))
        if k > l:
            l = k
    return l


if __name__ == "__main__":
    main()
