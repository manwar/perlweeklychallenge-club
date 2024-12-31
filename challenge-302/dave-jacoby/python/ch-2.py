#!/usr/bin/python3


def main():
    examples = [
        [-3, 2, -3, 4, 2],
        [1, 2],
        [1, -2, -3],
    ]
    for e in examples:
        output = step_by_step(e)
        print(f"    Input:  string = {e}")
        print(f"    Output: {output}")
        print("")


def step_by_step(ints):
    max = 20
    o = -1
    for i in [*range(1, max)]:
        n = i
        flag1 = 1
        for v in ints:
            if flag1:
                n += v
                if n < 1:
                    flag1 = 0
        if flag1:
            if o == -1:
                o = i
    return o


if __name__ == "__main__":
    main()
