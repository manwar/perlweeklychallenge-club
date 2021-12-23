#!/usr/bin/python3

# Challenge 031
#
# Task #1
# Create a function to check divide by zero error without checking if the
# denominator is zero.

def divide(num, den):
    try:
        res = num / den
    except ZeroDivisionError:
        return "division by zero trapped"
    else:
        return res

print(divide(5, 2 ))
print(divide(5, 0))
