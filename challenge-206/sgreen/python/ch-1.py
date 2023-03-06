#!/usr/bin/env python3

import sys


def main(times):
    # Let the default shortest time be something larger than everything
    shortest = 24*60

    # Convert the times into minutes after midnight
    minutes = [int(t[0:2]) * 60 + int(t[3:5]) for t in times]

    # Find all pairs
    for t1 in range(len(minutes)-1):
        for t2 in range(t1+1, len(minutes)):
            diff = abs(minutes[t1] - minutes[t2])
            # If the difference is more than 12 hours, it will be shorter if we cross midnight
            if diff > 12 * 60:
                diff = 24 * 60 - diff

            if diff < shortest:
                # We have found a new shortest span
                shortest = diff

    # Print the shortest span
    print(shortest)


if __name__ == '__main__':
    main(sys.argv[1:])
