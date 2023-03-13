#!/usr/bin/env python
# -*- coding: utf-8 -*-

roman_map = {
    "I": 1,
    "IV": 4,
    "V": 5,
    "IX": 9,
    "X": 10,
    "XL": 40,
    "L": 50,
    "XC": 90,
    "C": 100,
    "CD": 400,
    "D": 500,
    "CM": 900,
    "M": 1000,
}


def encode_to_roman(number):
    result = ""
    for roman, value in sorted(roman_map.items(), key=lambda x: -x[1]):
        while number >= value:
            result += roman
            number -= value
    return result


def decode_to_decimal(roman):
    result = 0
    index = 0
    while index < len(roman):
        if index < len(roman) - 1 and roman[index : index + 2] in roman_map:
            result += roman_map[roman[index : index + 2]]
            index += 2
        else:
            result += roman_map[roman[index]]
            index += 1
    return result


# Test the functions
roman_numeral = "CCXLVI"
print(f"Roman Numeral: {roman_numeral} -> Decimal: {decode_to_decimal(roman_numeral)}")

decimal_num = 39
print(f"Decimal: {decimal_num} -> Roman Numeral: {encode_to_roman(decimal_num)}")
