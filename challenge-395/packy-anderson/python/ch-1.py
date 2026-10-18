#!/usr/bin/env python

import re

def parse_complex(c):
  integer = '[+-]? \\d+ | \\( \\s* [+-]? \\d+ \\s* \\)'
  parse = re.compile(
    f'(?P<real>{integer})'  +
    f'\\s* (?P<op>[+-]) \\s*' +
    f'(?P<imag>{integer}) \\s* i', re.X
  )
  no_parens = re.compile(r'[()]')
  m = parse.match(c)
  if m:
    real = no_parens.sub("", m.group('real')) # strip parens
    imag = no_parens.sub("", m.group('imag'))
    real = int(real)
    imag = -1 * int(imag) if m.group('op') == '-' else int(imag)
    return (real, imag)

def complex_mult(num1, num2):
  a, b = parse_complex(num1)
  c, d = parse_complex(num2)
  e = (a * c) - (b * d)
  f = (a * d) + (b * c)
  f = f'({f})' if f < 0 else f
  return f'{e}+{f}i'

def solution(num1, num2):
  print(f'Input: $num1 = "{num1}", $num2 = "{num2}"')
  print(f'Output: "{complex_mult(num1, num2)}"')

print('Example 1:')
solution("1+1i", "1+1i")

print('\nExample 2:')
solution("1+(-1)i", "1+(-1)i")

print('\nExample 3:')
solution("0+3i", "0+4i")

print('\nExample 4:')
solution("3+4i", "3+(-4)i")

print('\nExample 5:')
solution("50+(-20)i", "-10+30i")

print('\nExample 6:')
solution("-2+5i", "5-5i")
