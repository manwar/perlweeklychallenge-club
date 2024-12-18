#!/usr/bin/python3

from itertools import permutations


def main():
    examples = [1, 2, 4, 10]
    for e in examples:
        output = beautiful_arrangement(e)
        print(f'    Input:  int = {e}')
        print(f"    Output: {output}")
        print("")


def beautiful_arrangement(i):
    array = [*range(1, i + 1)]
    size = len(array)
    p = permutations(array)
    c = 0
    for j in list(p):
        n = 0
        perm = list(j)
        perm.insert(0, 0)
        for i in [*range(1, i + 1)]:
            v = perm[i]
            r1 = i / v
            r2 = v / i
            i1 = int(r1)
            i2 = int(r2)
            if r1 == i1 or r2 == i2:
                n += 1
        if n == size:
            c += 1
    return c


if __name__ == "__main__":
    main()
