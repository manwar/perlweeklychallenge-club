#!/usr/bin/env python
'''
I got these Roman-Int, Int-Roman routines from O'Reilly
Module: Roman Numerals
Credit: Paul M. Winkler

AUTHOR: Robert DiCicco
DATE  : 2023-07-26
Challenge 227 Task 2 Roman Maths ( Python )
'''
import sys

class py_solution:
    def int_to_Roman(self, num):
        val = [
            1000, 900, 500, 400,
            100, 90, 50, 40,
            10, 9, 5, 4,
            1
            ]
        syb = [
            "M", "CM", "D", "CD",
            "C", "XC", "L", "XL",
            "X", "IX", "V", "IV",
            "I"
            ]
        roman_num = ''
        i = 0
        while  num > 0:
            for _ in range(num // val[i]):
                roman_num += syb[i]
                num -= val[i]
            i += 1
        return roman_num


    def roman_to_int(self, input):
        input = input.upper()
        roman_numeral_map = (('M', 1000, 3), ('CM', 900, 1),
            ('D', 500, 1), ('CD', 400, 1),
            ('C', 100, 3), ('XC', 90, 1),
            ('L', 50, 1), ('XL', 40, 1),
            ('X', 10, 3), ('IX', 9, 1),
            ('V', 5, 1), ('IV', 4, 1), ('I', 1, 3))
        result, index = 0, 0
        for numeral, value, maxcount in roman_numeral_map:
            count = 0
            while input[index: index+len(numeral)] == numeral:
                count += 1 # how many of this numeral we have
                result += value
                index += len(numeral)
        return result

def main():
    n = len(sys.argv)
    if n != 2:
        print("Please enter a math problem using Roman numerals")
        sys.exit(1)

    problem = sys.argv[1]
    parts = problem.split()
    left = parts[0]
    op = parts[1]
    right = parts[2]
    lft = py_solution().roman_to_int(left)
    rt  = py_solution().roman_to_int(right)

    if ( op == '-' and lft - rt == 0):
        print(f"{problem} est nulla")
        sys.exit(1)
    elif (op == '/' and (lft % rt) > 0 ):
        print(f"{problem} non potest")
        sys.exit(1)
    elif (op == '+' and lft + rt > 3999):
        print(f"{problem} non potest");
        sys.exit(1)
    elif (op == '-' and (lft - rt < 0)):
        print(f"{problem} non potest")
        sys.exit(1)
    elif (op == '/' and (lft % rt != 0)):
        print(f"{problem} non potest")
        sys.exit(1)

    if ( op == '+'):
        val = py_solution().int_to_Roman(lft + rt)
    elif ( op == '-'):
        val = py_solution().int_to_Roman(lft - rt)
    elif ( op == '/'):
        val = py_solution().int_to_Roman(int(lft / rt))
    elif ( op == '*'):
        val = py_solution().int_to_Roman(int(lft * rt))
    elif ( op == '**'):
        val = py_solution().int_to_Roman(int(lft ** rt))

    print(f"{problem} => {val}")

if __name__ == "__main__":
    main()

'''
-----------------------------------------------------------------
SAMPLE OUTPUT
python .\RomanMath.py "IV + V"
IV + V => IX

python .\RomanMath.py "M - I"
M - I => CMXCIX

python .\RomanMath.py "X / II"
X / II => V

python .\RomanMath.py "XI * VI"
XI * VI => LXVI

python .\RomanMath.py "VII ** III"
VII ** III => CCCXLIII

python .\RomanMath.py "V - V"
V - V est nulla

python .\RomanMath.py "V / II"
V / II non potest

python .\RomanMath.py "MMM + M"
MMM + M non potest

python .\RomanMath.py "V - X"
V - X non potest
'''


