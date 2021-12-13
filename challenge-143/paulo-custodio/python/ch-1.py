#!/usr/bin/python3

# TASK #1 > Calculator
# Submitted by: Mohammad S Anwar
# You are given a string, $s, containing mathematical expression.
# 
# Write a script to print the result of the mathematical expression. To keep
# it simple, please only accept + - * ().
# 
# Example 1:
#     Input: $s = "10 + 20 - 5"
#     Output: 25
# Example 2:
#     Input: $s = "(10 + 20 - 5) * 2"
#     Output: 50

import sys
import re

def expr(input):
    input, value = factor(input)
    while True:
        input = input.strip()+" "
        if input[0]=='*':
            input = input[1:]
            input, b = factor(input)
            value *= b
        elif input[0]=='/':
            input = input[1:]
            input, b = factor(input)
            value /= b
        else:
            return input, value

def factor(input):
    input, value = term(input)
    while True:
        input = input.strip()+" "
        if input[0]=='+':
            input = input[1:]
            input, b = term(input)
            value += b
        elif input[0]=='-':
            input = input[1:]
            input, b = term(input)
            value -= b
        else:
            return input, value
    
def term(input):
    input = input.strip()+" "
    match = re.match(r"[-+]?\d+", input)
    if match:
        value = int(match.group(0))
        input = input[match.end(0):]
        return input, value
    elif input[0]=='(':
        input = input[1:]
        input, value = expr(input)
        input = input.strip()+" "
        if input[0]!=')':
            print("expected )")
            sys.exit(1)
        input = input[1:]
        return input, value
    else:
        print("expected ( or number")
        sys.exit(1)

input = " ".join(sys.argv[1:])
input, value = expr(input)
print(value)
