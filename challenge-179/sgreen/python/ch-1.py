#!/usr/bin/env python3

import sys


def main(s):
    n = int(s)
    if n >= 10 ** 12:
        raise ValueError('Number too large')

    numbers = [None, 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten',
               'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
    tens = [None, None, 'twenty', 'thirty', 'fourty',
            'fifty', 'sixty', 'seventy', 'eighty', 'ninety']
    ordinal = [None, 'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth',
               'eleventh', 'twelfth', 'thirteenth', 'fourteenth', 'fifteenth', 'sixteenth', 'seventeenth', 'eighteenth', 'nineteenth']
    thousands = [None, 'thousand', 'million', 'billion']

    # Split the string into blocks of three
    blocks = []
    while len(s) > 3:
        # Take off the last three numbers
        blocks.append(int(s[-3:]))
        s = s[:-3]
    blocks.append(int(s))

    words = []
    for count, value in enumerate(blocks):
        w = ''

        # Maybe this block has no numbers
        if value == 0:
            continue

        # Deal with the hundreds first
        if value >= 100:
            w = numbers[int(value/100)] + ' hundred'

            if value % 100 == 0:
                # Deal with numbers evenly divisable by 100
                if count > 0:
                    w += ' ' + thousands[count]
                words.insert(0, w)
                continue

            w += ' and '
            value = value % 100

        # Then the tens
        if value >= 20:
            w += tens[int(value/10)] + ' '
            value = value % 10
            if value == 0 and count == 0:
                # We need to add the ordinal word here
                w = w[:-2] + 'ieth'

        # And then the number
        if value != 0:
            t = ordinal if count == 0 else numbers
            w += t[value]

        # And maybe the thousandth word
        if count > 0:
            w += ' ' + thousands[count]

        words.insert(0, str(w))

    # Edge case, if the number is evenly divisible by 100, add 'th' to the last value
    if int(n) % 100 == 0:
        words[-1] += 'th'

    # Print the ordinal number
    print(*words, sep=' ')


if __name__ == '__main__':
    main(sys.argv[1])
