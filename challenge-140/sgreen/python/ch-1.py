#!/usr/bin/env python

import re
import sys


class BinaryDecimal:
    def __init__(self, value):
        # Check we were supplied with a binary string
        if not re.match(r'^[01]+$', value):
            raise Exception(f'The value {value} is not binary')
        self.value = int(value)

    def __add__(self, other):
        value1 = self.value
        value2 = other.value
        result = 0
        power = 0
        carry = 0

        while (carry or value1 or value2):
            digit = value1 % 10 + value2 % 10 + carry
            if digit >= 2:
                carry = 1
                digit -= 2
            else:
                carry = 0

            if digit == 1:
                result += 10 ** power

            value1 = int(value1 / 10)
            value2 = int(value2 / 10)
            power += 1

        return result


def main(inputs):
    value1 = BinaryDecimal(inputs[0])
    value2 = BinaryDecimal(inputs[1])
    print(value1 + value2)


if __name__ == '__main__':
    main(sys.argv[1:])
