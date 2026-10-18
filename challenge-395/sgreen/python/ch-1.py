#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import re
import sys


def to_complex(s: str) -> complex:
    """Convert the input string to a complex number"""
    if m := re.search(r"^(-?\d+)\+(\d+)i$", s):
        return complex(int(m.group(1)), int(m.group(2)))
    if m := re.search(r"^(-?\d+)\+\((-\d+)\)i$", s):
        return complex(int(m.group(1)), int(m.group(2)))
    raise ValueError("Unexpected input: %s", s)


def complex_number(num1: str, num2: str) -> str:
    """
    return the multiplication of the given complex numbers.

    Params:
        num1 (str): The first complex number
        num2 (str): The second complex number

    Returns:
        str: The result of the calculation
    """
    # Convert the strings to complex numbers
    c1 = to_complex(num1)
    c2 = to_complex(num2)

    # Perform the multiplication, and extract the real and imaginary part
    result = c1 * c2
    result_real = int(result.real)
    result_imag = int(result.imag)

    # Return the result in the expected output
    return (
        f"{result_real}+{'('+str(result_imag)+')' if result_imag < 0 else result_imag}i"
    )


def main():
    """Convert command line input into parameters for the function and display result"""
    result = complex_number(*sys.argv[1:])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
