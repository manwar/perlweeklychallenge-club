#!/usr/bin/env python3

import sys
from datetime import date


def get_dofy(dt):
    '''Turn a date in DD-MM format into day of year'''
    (day, month) = dt.split('-')
    d = date(2022, int(month), int(day))
    return int(d.strftime('%j'))


def main(array):
    '''Calculate the days that foo and bar spent together'''

    # Convert the input into the day of year
    foo_start = get_dofy(array[0])
    foo_end = get_dofy(array[1])
    bar_start = get_dofy(array[2])
    bar_end = get_dofy(array[3])

    # Make sure they arrive before they leave!
    if foo_end < foo_start:
        raise ValueError('foo left before they arrived!')
    if bar_end < bar_start:
        raise ValueError('bar left before they arrived!')

    # The time they spent together is when the last person arrives and the first one leave.
    both_start = max(foo_start, bar_start)
    both_end = min(foo_end, bar_end)

    # Display the days spent together
    if both_end < both_start:
        print('0 days')
    elif both_start == both_end:
        print('1 day')
    else:
        print(f'{both_end - both_start + 1} days')


if __name__ == '__main__':
    main(sys.argv[1:5])
