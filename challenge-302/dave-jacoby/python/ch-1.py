#!/usr/bin/python3

from itertools import permutations


def main():
    examples = [
        {
            "x": 5,
            "y": 3,
            "str": ["10", "0001", "111001", "1", "0"],
        },
        {
            "x": 1,
            "y": 1,
            "str": ["10", "1", "0"],
        },
    ]
    for e in examples:
        x = e["x"]
        y = e["y"]
        str = e["str"]
        output = ones_and_zeros(e)
        print(f"    Input:  str = {str}")
        print(f"            x   = {x}")
        print(f"            y   = {y}")
        print(f"    Output: {output}")
        print("")


def ones_and_zeros(e):
    x = e["x"]
    y = e["y"]
    str = e["str"]
    l = 1 + len(str)
    o = []
    sizes = [*range(1, l)]
    sizes.reverse()
    for s in sizes:
        str1 = e["str"]
        ps = permutations(str1, s)
        for p in ps:
            pstr = "".join(x for x in p)
            cx = pstr.count("0")
            cy = pstr.count("1")
            if cx == x and cy == y:
                o.append(s)
    return o[0]


if __name__ == "__main__":
    main()
