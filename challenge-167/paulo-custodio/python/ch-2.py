#!/usr/bin/env python3

# Challenge 167
#
# Task 2: Gamma Function
# Submitted by: Mohammad S Anwar
#
# Implement subroutine gamma() using the Lanczos approximation method.
#
# [2022-05-31]
#
# Ryan Thompson wrote an interesting blog explaining the subject in details.
# Highly recommended if you are looking for more information. BLOG.
#
# Example
#
# print gamma(3); # 1.99
# print gamma(5); # 24
# print gamma(7); # 719.99

import sys
import cmath
import math

# Constants
g = 7
p = [
    0.99999999999980993227684700473478,
    676.520368121885098567009190444019,
    -1259.13921672240287047156078755283,
    771.3234287776530788486528258894,
    -176.61502916214059906584551354,
    12.507343278686904814458936853,
    -0.13857109526572011689554707,
    9.984369578019570859563e-6,
    1.50563273514931155834e-7
]

EPSILON = 1e-07

def drop_imag(z):
    if abs(z.imag) <= EPSILON:
        z = z.real
    return z

def gamma(z):
    if z.real < 0.5:
        y = math.pi / (math.sin(math.pi * z) * gamma(1 - z))  # Reflection formula
    else:
        z -= 1
        x = p[0]
        for i in range(1, len(p)):
            x += p[i] / (z + i)
        t = z + g + 0.5
        t = drop_imag(t)
        y = math.sqrt(2 * math.pi) * t ** (z + 0.5) * math.exp(-t) * x
    return drop_imag(y)

# Example usage
z = complex(float(sys.argv[1]))
print(f"{gamma(z):.0f}")
