#!/usr/bin/env python3

# Perl Weekly Challenge 178 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-178/

import sys

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

if len(sys.argv) == 3 and sys.argv[1]=="dec_to_base2i":
    print(dec_to_base2i(int(sys.argv[2])))
elif len(sys.argv) == 3 and sys.argv[1]=="base2i_to_dec":
    print(base2i_to_dec(sys.argv[2]))
else:
    print("usage: "+sys.argv[0]+" dec_to_base2i|base2i_to_dec n")
