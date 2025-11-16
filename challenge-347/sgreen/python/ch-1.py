#!/usr/bin/env python3

import re
import sys

DAYS = [
    "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th",
    "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th",
    "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th",
    "29th", "30th", "31st"
]

MONTHS = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
    "Nov", "Dec"
]

YEARS = list(map(str, range(1900, 2101)))


def format_date(input_string: str) -> str:
    fields = [
        ("day of month", DAYS, 1),
        ("month", MONTHS, 1),
        ("year", YEARS, 1900)
    ]

    input_list = input_string.split()
    output_list = []

    if len(input_list) != 3:
        raise ValueError("Input must contain day, month, and year")

    for i in (range(3)):
        name, values, offset = fields[i]
        value = input_list[i]
        if value not in values:
            raise ValueError(f"Invalid {name}: {value}")
        index = values.index(value) + offset
        output_list.append(f"{index:02d}")

    return "-".join(reversed(output_list))


def main():
    result = format_date(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
