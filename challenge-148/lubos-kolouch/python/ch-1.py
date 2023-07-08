#!/usr/bin/env python
# -*- coding: utf-8 -*-
def generate_eban_numbers(limit):
    words = {
        1: "one",
        2: "two",
        3: "three",
        4: "four",
        5: "five",
        6: "six",
        7: "seven",
        8: "eight",
        9: "nine",
        10: "ten",
        11: "eleven",
        12: "twelve",
        13: "thirteen",
        14: "fourteen",
        15: "fifteen",
        16: "sixteen",
        17: "seventeen",
        18: "eighteen",
        19: "nineteen",
        20: "twenty",
        30: "thirty",
        40: "forty",
        50: "fifty",
        60: "sixty",
        70: "seventy",
        80: "eighty",
        90: "ninety",
        100: "one hundred",
    }

    eban_numbers = []
    for num in range(1, limit + 1):
        if num <= 20 or num == 100:
            word = words[num]
        elif num < 100:
            if num % 10 == 0:
                word = words[num]
            else:
                word = words[num // 10 * 10] + " " + words[num % 10]
        else:
            word = words[num // 100] + " " + words[100] + " " + words[num % 100]

        if "e" not in word:
            eban_numbers.append(num)

    return eban_numbers


print(generate_eban_numbers(100))
