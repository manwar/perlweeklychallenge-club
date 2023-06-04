#!/usr/bin/env python

import sys


def buy_pass(passes, travel_on):
    if len(travel_on) == 0:
        return 0

    first_day = travel_on[0]
    minimum_spend = None

    for days, cost in passes.items():
        spend = cost + \
            buy_pass(passes, [i for i in travel_on if i >= first_day + days])
        if minimum_spend is None or spend < minimum_spend:
            minimum_spend = spend

    return minimum_spend


def main(array):
    # Take the first three values off
    passes = {}
    passes[1] = array.pop(0)
    passes[7] = array.pop(0)
    passes[30] = array.pop(0)

    # Note the days we want to travel on
    travel_on = sorted(array)
    spent = buy_pass(passes, travel_on)
    print(spent)


if __name__ == '__main__':
    array = [int(n) for n in sys.argv[1:]]
    main(array)
