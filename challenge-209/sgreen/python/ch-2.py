#!/usr/bin/env python3

import json
import sys


def group_lists(account, group):
    rows = []

    while len(group):
        # Retrieve the first row
        addresses = group.pop(0)

        # See if there is a match with other rows
        for i, other in enumerate(group):
            if addresses & other:
                # There is, merge the rows and prepend them to the list
                o = group.pop(i)
                group.insert(0, addresses | o)
                break
        else:
            # There isn't. Add this row to the rows list
            rows.append(list(account) + list(addresses))

    return rows


def main(array):
    # Group the input by account, where the e-mails are sets
    groups = {}
    for row in array:
        account = row.pop(0)
        if account not in groups:
            groups[account] = []
        groups[account].append(set(row))

    # Turn each group into the final lists
    results = []
    for account in sorted(groups):
        results.extend(group_lists(account, groups[account]))

    print(json.dumps(results, indent=4))


if __name__ == '__main__':
    main(json.loads(sys.argv[1]))
