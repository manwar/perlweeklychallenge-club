#!/usr/bin/env python3

# Challenge 178
#
# Task 1: Quater-imaginary Base
# Submitted by: Mohammad S Anwar
#
# Write a script to convert a given number (base 10) to quater-imaginary base
# number and vice-versa. For more informations, please checkout wiki page.
#
# For example,
#
# $number_base_10 = 4
# $number_quater_imaginary_base = 10300

def dec_to_base2i(n):
    base = -4
    result = ""
    while n != 0:
        i = n % base
        n //= base
        if i < 0:
            i += abs(base)
            n += 1
        result = "0" + str(i) + result  # imaginary is zero
    result = result.lstrip('0')
    return result

def base2i_to_dec(n2i):
    base = -4
    result = 0
    digits = list(reversed(n2i))
    for i in range(len(digits)):
        if i % 2 == 0:  # real part
            result += int(digits[i]) * (base ** (i // 2))
        elif digits[i] != '0':  # imaginary part
            raise ValueError(f"number {n2i} has imaginary component")
    return result

assert(dec_to_base2i(4) == '10300')
assert(base2i_to_dec('10300') == 4)
