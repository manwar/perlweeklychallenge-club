#!/usr/bin/python3

import copy


def main():
    examples = [[5, 4, 0, 3, 1, 6, 2], [0, 1, 2], [2, 0, 1, 3]]
    for e in examples:
        output = nested_array(e)
        print(f"    Input:  string = {e}")
        print(f"    Output: {output}")
        print("")


def nested_array(ints):
    loops = []
    size = len(ints)
    for i in [*range(size)]:
        nested = []
        flag = 1
        n = i
        while flag:
            if n in nested:
                loops.append(len(nested))
                flag = 0
            else:
                v = ints[n]
                nested.append(n)
                n = v
    return max(loops)


if __name__ == "__main__":
    main()
