#!/usr/bin/env python3

import sys


def no_connection(routes: list) -> str:
    # Calculate a list of origins (first value) and destinations (second value)
    origins = [v[0] for v in routes]
    destinations = [v[1] for v in routes]

    # Find route destinations that aren't also an origin
    dead_ends = [d for d in destinations if d not in origins]

    if len(dead_ends) > 1:
        raise ValueError(
            'There are multiple routes with no outgoing connection')

    if len(dead_ends) == 0:
        raise ValueError('All routes have an outgoing connection')

    return dead_ends[0]


def main():
    # Convert input into pairs. The first value is the start of route.
    # The second value is the destination
    routes = []
    for i in range(1, len(sys.argv), 2):
        routes.append([sys.argv[i], sys.argv[i+1]])
    result = no_connection(routes)
    print(result)


if __name__ == '__main__':
    main()
