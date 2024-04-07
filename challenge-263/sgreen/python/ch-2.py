#!/usr/bin/env python3

from collections import defaultdict
import json
import sys


def merge_items(*arrays) -> list:
    # Calculate the total of each items
    totals = defaultdict(int)
    for array in arrays:
        for item in array:
            item_id, item_qty = item
            totals[item_id] += item_qty

    # Turn this into a sorted list of item_id and item_qty pairs
    return [[item, totals[item]] for item in sorted(totals)]


def main():
    # Convert each input into a list of lists
    arrays = []
    for json_str in sys.argv[1:]:
        arrays.append(json.loads(json_str))
    result = merge_items(*arrays)
    print(json.dumps(result))


if __name__ == '__main__':
    main()
