#!/usr/bin/env python

import sys


def main(s):
    '''Main function'''
    # Turn input into integers
    nums = [int(x) for x in s]

    # See if there is a possible target
    target = sum(nums) / len(nums)
    items = len(nums)
    moves = 0

    if target % 1 != 0:
        # There is no possible solution
        print(-1)
        return

    target = int(target)
    for i in range(items):
        # How many do we need to make the value the target
        needed = target - nums[i]

        while needed > 0:
            # Loop from the left to find which items we can remove numbers from
            for j in range(items):
                has = nums[j]

                # We have found a value we can take from
                if has > target:
                    # Calculate how many we can take
                    take = min(needed, has - target)

                    nums[i] += take
                    nums[j] -= take
                    needed -= take

                    # Record the number of moves it would take to steal
                    #  from the other item
                    moves += take * abs(i-j)

    print(moves)


if __name__ == '__main__':
    main(sys.argv[1:])
