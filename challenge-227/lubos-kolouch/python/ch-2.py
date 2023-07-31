#!/usr/bin/env python
# -*- coding: utf-8 -*-

import roman


def roman_maths(expr):
    # Parse the expression into two Roman numerals and the operation
    num1, op, num2 = expr.split()
    num1 = roman.fromRoman(num1.upper())
    num2 = roman.fromRoman(num2.upper())
    # Perform the operation
    if op == '+':
        result = num1 + num2
    elif op == '-':
        result = num1 - num2
    elif op == '*':
        result = num1 * num2
    elif op == '/':
        if num2 == 0:
            return "non potest"  # they didn't do fractions
        result = num1 // num2
    elif op == '**':
        result = num1 ** num2
    else:
        return "Invalid operation"
    # Check the result
    if result <= 0:
        return "nulla" if result == 0 else "non potest"  # they didn't do negative numbers
    elif result > 3999:
        return "non potest"  # they only went up to 3999
    # Convert the result back into a Roman numeral
    return roman.toRoman(result)


print(roman_maths("IV + V"))  # should print IX
print(roman_maths("M - I"))  # should print CMXCIX
print(roman_maths("X / II"))  # should print V
print(roman_maths("XI * VI"))  # should print LXVI
print(roman_maths("VII ** III"))  # should print CCCXLIII
print(roman_maths("V - V"))  # should print nulla
print(roman_maths("V / II"))  # should print non potest
print(roman_maths("MMM + M"))  # should print non potest
print(roman_maths("V - X"))  # should print non potest
