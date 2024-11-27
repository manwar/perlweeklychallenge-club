#!/usr/bin/python3

import re


def main():
    examples = [
        [1, 0],
        [0, 1, 0],
        [0, 0, 0, 0, 0],
        [0, 1, 0, 0, 1, 0],
    ]
    for e in examples:
        s = []
        for i in e:
            s.append(str(i))
        input = ", ".join(s)
        output = continuous_array(e)
        print(f"    Input:  binary = ({input})")
        print(f"    Output: {output}")
        print("")


def continuous_array(array):
    l = 0
    max = 1 + len(array)
    for i in range(0, max):
        for j in range(i + 1, max):
            indexes = [*range(i, j)]
            values = [array[k] for k in indexes]
            length = len(indexes)
            zeros = 0
            ones = 0
            for v in values:
                if v == 0:
                    zeros += 1
                if v == 1:
                    ones += 1
            if zeros == ones:
                if length > l:
                    l = length
    return l


if __name__ == "__main__":
    main()
