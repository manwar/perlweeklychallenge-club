#!/usr/bin/env python3

import sys


def rob(haul, valuables):
    if len(valuables) <= 2:
        # We rob the remaining house, and take off with the haul!
        return haul + valuables[0]

    # Call the function recursively skipping either one or two houses
    hauls = []
    hauls.append(rob(haul+valuables[0], valuables[2:]))
    if len(valuables) >= 4:
        hauls.append(rob(haul+valuables[0], valuables[3:]))

    # Return the largest haul
    return max(hauls)


def main(inputs):
    valuables = list(map(int, inputs))
    largest_haul = rob(0, valuables)
    print(largest_haul)


if __name__ == '__main__':
    main(sys.argv[1:])
