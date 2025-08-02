#!/usr/bin/python3


def main():
    examples = [[4, 14, 2], [4, 14, 4], [0, 1, 2, 4, 32]]
    for e in examples:
        output = hamming_distance(e)
        print(f"    Input:  string = {e}")
        print(f"    Output: {output}")
        print("")


def hamming_distance(ints):
    o = 0
    end = len(ints)
    for i in [*range(end)]:
        ii = ints[i]
        bi = format(ii, "b").rjust(8, "0")
        for j in [*range(i + 1, end)]:
            jj = ints[j]
            bj = format(jj, "b").rjust(8, "0")
            c = count_diffs(bi, bj)
            o += c
    return o


def count_diffs(bi, bj):
    m = max(map(len, (bi, bj)))
    c = 0
    for i in [*range(m)]:
        si = bi[i : i + 1]
        sj = bj[i : i + 1]
        if si != sj:
            c += 1
    return c


if __name__ == "__main__":
    main()
