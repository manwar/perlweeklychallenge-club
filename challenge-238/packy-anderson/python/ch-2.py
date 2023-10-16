#!/usr/bin/env python

from functools import cmp_to_key, reduce

def persistenceSort(int_list):
    step_count = {}
    steps = ""

    # first, calculates the steps for each number
    for num in int_list:
        step_count[num] = 0

        steps += f"\n{num}" # our starting number

        num_copy = str(num) # copy the num so we can modify it

        while len(num_copy) > 1:
            # split num_copy into its individual digits
            digits = list(num_copy)

            # generate a new number by multiplying all the digits
            num_copy = str(
                reduce(
                    lambda a, b: int(a) * int(b),
                    digits
                )
            )

            # show the multiplication in the steps for this num
            steps += ' => ' + ' x '.join(digits)
            steps += ' => ' + num_copy

            # add to our count of steps
            step_count[num] += 1

        # put the step count in the steps for this num
        step_word = 'step' if step_count[num] == 1 else 'steps'
        steps += f" ({step_count[num]} {step_word})"

    # now, sort by steps/numeric value
    sorted_list = sorted(int_list,
                         key=lambda x: (step_count[x], x))

    return sorted_list, steps

def solution(int_list):
    as_list = ', '.join(map(lambda i: str(i), int_list))
    print(f'Input: @int = ({as_list})')
    sorted_list, steps = persistenceSort(int_list)
    as_list = ', '.join(map(lambda i: str(i), sorted_list))
    print(f'Output: ({as_list})')
    print(steps)

print('Example 1:')
solution([15, 99, 1, 34])

print('\nExample 2:')
solution([50, 25, 33, 22])