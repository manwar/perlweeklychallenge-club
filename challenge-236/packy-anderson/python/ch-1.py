#!/usr/bin/env python

def isExactChangePossible(bills):
    till = {}; # we keep the bills in a "till"
    for collected in bills:
        # put the bill we collected in the "till"
        #
        # using .get(collected, 0) yields the value in the
        # dict for the key 'collected' if it exists, or the
        # specified default (in this case, 0) if it doesn't
        till[collected] = till.get(collected, 0) + 1

        # calculate the required change
        change_required = collected - 5

        # loop through the bills we have on hand
        for bill in sorted(till, reverse=True):
            # as long as we have more of this bill and
            # using it would not yield TOO MUCH change
            while till[bill] > 0 and change_required - bill >= 0:
                # deduct the amount from the required change
                change_required -= bill

                # remove the bill from the till
                till[bill] -= 1

        # if we weren't able to make change, fail
        if change_required:
            return 0

    # we successfully made change for all transactions!
    return 1

def solution(bills):
    as_list = ', '.join(map(lambda i: str(i), bills))
    print(f'Input: @bills = ({as_list})')
    output = isExactChangePossible(bills)
    print(f'Output: {"true" if output else "false"}')


print('Example 1:')
solution([5, 5, 5, 10, 20])

print('\nExample 2:')
solution([5, 5, 10, 10, 20])

print('\nExample 3:')
solution([5, 5, 5, 20])
