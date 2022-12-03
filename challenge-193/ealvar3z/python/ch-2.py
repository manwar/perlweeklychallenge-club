#!/usr/bin/env python3


def odd_str(_list):
    def diff(x): return [ord(x[i]) - ord(x[i - 1]) for i in range(1, len(x))]
    _list.sort(key=diff)

    fst = _list[0]
    snd = _list[1]
    last = _list[-1]

    return fst if diff(fst) != diff(snd) else last


def main():
    words = ["adc", "wzy", "abc"]
    print(odd_str(words))


if __name__ == "__main__":
    exit(main())
