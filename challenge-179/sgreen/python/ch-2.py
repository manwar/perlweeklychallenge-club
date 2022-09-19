#!/usr/bin/python3

import sys


def main(strings):
    numbers = [float(x) for x in strings]
    bar = '▁▂▃▄▅▆▇█'
    barcount = len(bar)

    mn, mx = min(numbers), max(numbers)
    extent = mx - mn
    sparkline = ''.join(bar[min([barcount - 1,
                                int((n - mn) / extent * barcount)])]
                        for n in numbers)
    print(sparkline)


if __name__ == '__main__':
    main(sys.argv[1:])
