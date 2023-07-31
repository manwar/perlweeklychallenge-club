#!/usr/bin/env python3

import sys


def from_roman(roman):
    mapping = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}
    digits = [mapping[s] for s in roman]

    number = 0
    for i, v in enumerate(digits):
        if i < len(digits)-1 and v < digits[i+1]:
            number -= v
        else:
            number += v

    return number


def to_roman(number):
    if number == 0:
        return 'nulla'
    elif number > 3999 or number < 0:
        return 'non potest'
    elif type(number) == float:
        if not number.is_integer():
            return 'non potest'
        number = int(number)

    mapping = [
        ['', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', ],
        ['', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC', ],
        ['', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM', ],
        ['', 'M', 'MM', 'MMM', ],
    ]

    # Convert it into a string
    roman = ''
    number = str(number)

    # Iterate in reverse
    for i, d in enumerate(number[::-1]):
        roman = mapping[i][int(d)] + roman

    return roman


def main(roman1, oper, roman2):
    number1 = from_roman(roman1)
    number2 = from_roman(roman2)

    if oper == '+':
        number = number1 + number2
    elif oper == '-':
        number = number1 - number2
    elif oper == '*' or oper == '×':
        number = number1 * number2
    elif oper == '/' or oper == '÷':
        number = number1 / number2
    elif oper == '**':
        number = number1 ** number2
    else:
        raise ValueError(f"Unknown operator: '{oper}'")

    print(to_roman(number))


if __name__ == '__main__':
    main(*sys.argv[1:])
