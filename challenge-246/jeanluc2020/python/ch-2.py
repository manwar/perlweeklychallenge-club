#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/#TASK2
#
# Task 2: Linear Recurrence of Second Order
# =========================================
#
# You are given an array @a of five integers.
#
# Write a script to decide whether the given integers form a linear recurrence
# of second order with integer factors.
#
# A linear recurrence of second order has the form
#
#  a[n] = p * a[n-2] + q * a[n-1] with n > 1
#
# where p and q must be integers.
#
#
## Example 1
##
## Input: @a = (1, 1, 2, 3, 5)
## Output: true
##
## @a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1]
## with a[0] = 1 and a[1] = 1.
#
## Example 2
##
## Input: @a = (4, 2, 4, 5, 7)
## Output: false
##
## a[1] and a[2] are even. Any linear combination of two even numbers with
## integer factors is even, too.
## Because a[3] is odd, the given numbers cannot form a linear recurrence of
## second order with integer factors.
#
## Example 3
##
## Input: @a = (4, 1, 2, -3, 8)
## Output: true
##
## a[n] = a[n-2] - 2 * a[n-1]
#
############################################################
##
## discussion
##
############################################################
#
# We need a solution that allows for
# p * a[0] + q * a[1] = a[2]
# p * a[1] + q * a[2] = a[3]
# p * a[2] + q * a[3] = a[4]
#
# A linear combination of a number a in term of two other numbers b and c
# is possible if gcd(b,c) divides a; however there might be multiple
# such combinations possible so it is not possible from one triplet of
# numbers to determine which (if any) linear recurrence works for all
# 5 numbers. For example (4,2,4): 1*4+0*2=4, 0*4+2*2=4, 2*4-2*2=4,
# 3*4-4*2=4, -1*4+8*2=4, ...
# The gcd method however allows to check whether there is any potential
# solution at all, so let's start with that. Since the gcd of two numbers
# can slso be combined linearly out of the two numbers I can only assume
# the task was meant to use that, however in the general case we might have
# to check any of the (potentially infinitely many) linear combinations for
# whether or not their factors are suitable for the whole chain of numbers,
# and it doesn't even hold true for the first example.
# So we can try to find a few linear combinations from the first triplet,
# and if any of those works for all numbers we're good.
# As a heuristic for the range of p and q we use +/- |a|+|b| and try more or
# less all combinations of these; since we have multiple numbers we just
# take the maximum of those numbers * 2 instead.
#

def true():
    print("Output: true")
    return True

def false():
    print("Output: false")
    return False

def absmax(elems: list):
    max = abs(elems[0])
    for elem in elems:
        if abs(elem) > max:
            max = abs(elem)
    return max

def gcd(x: int, y: int) -> int:
    if x < 0:
        return gcd(-x, y)
    if y < 0:
        return gcd(x, -y)
    if x < y:
        return gcd(y, x)
    z = x % y
    if z > 0:
        return gcd(y, z)
    return y

def linear_recurrence_of_second_order(a: list) -> bool:
    (i, j, k, l, m) = a

    if k % gcd(i, j) > 0:
        return false()
    if l % gcd(j, k) > 0:
        return false()
    if m % gcd(k, l) > 0:
        return false()

    limit = 2 * absmax(a)

    for p in range(-limit, 2*limit):
        for q in range(-limit, 2*limit):
            if p*i + q*j == k:
                if p*j + q*k == l:
                    if p*k + q*l == m:
                        return true()
    return false()


linear_recurrence_of_second_order([1, 1, 2, 3, 5])
linear_recurrence_of_second_order([4, 2, 4, 5, 7])
linear_recurrence_of_second_order([4, 1, 2, -3, 8])
