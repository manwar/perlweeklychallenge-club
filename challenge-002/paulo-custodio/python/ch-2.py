#!/usr/bin/env python

# Challenge 002
#
# Challenge #2
# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y. Dave Jacoby came up
# with nice description about base35, in case you needed some background.

import sys

def format_digit(n):
    if n<10:
        return chr(n+ord('0'))
    else:
        return chr(n+ord('A')-10)

def format_number(n, base):
    negative = True if n<0 else False
    n = abs(n)
    output = ""
    while True:
        d = n % base
        n = int(n / base)
        output = format_digit(d) + output
        if n == 0: break
    if negative:
        output = "-" + output
    return output

def scan_digit(str):
    str = str.upper()
    if str >= "0" and str <= "9":
        return ord(str)-ord("0")
    elif str >= "A" and str <= "Z":
        return ord(str)-ord("A")+10
    else:
        return -1

def scan_number(str, base):
    n, negative = 0, False
    if str[0] == "-":
        str = str[1:]
        negative = True
    while str != "":
        d = scan_digit(str[0])
        str = str[1:]
        assert d>=0 and d<base
        n = n*base + d
    if negative:
        n = -n
    return n

if sys.argv[1] == "-r":
    print(scan_number(sys.argv[2], 35))
else:
    print(format_number(int(sys.argv[1]), 35))
