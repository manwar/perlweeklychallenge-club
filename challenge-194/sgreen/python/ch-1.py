#!/usr/bin/env python3

import sys

def main(time):
    value = None
    if time[0] == '?':
        # 2 if the second hour value is <= 3 else 1
        value = 2 if int(time[1]) <= 3 else 1
    elif time[1] == '?':
        # 3 if the first hour value is 2 else 9
        value = 3 if time[0] == '2' else 9
    elif time[3] == '?':
        # The maximum first minute value is always 5
        value = 5
    else:
        # The maximum second minute value is always 9
        value = 9

    print(value)

if __name__ == '__main__':
    main(sys.argv[1])