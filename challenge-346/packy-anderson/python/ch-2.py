#!/usr/bin/env python

from itertools import chain
import re

has_leading_zero = re.compile("[^0-9]0[0-9]+")

def to_str(digits, ops):
  return "".join(
    list( chain.from_iterable( zip(digits, ops+[""]) ) )
  )

def magic_expression3(op, target, digits, ops, pos, found):
  ops[pos] = op
  mystr = to_str(digits, ops)
  if not has_leading_zero.search(mystr) and target == eval(mystr):
    found[mystr] = 1
  magic_expression2(target, digits, ops, pos+1, found)

def magic_expression2(target, digits, ops, pos, found):
  if pos >= len(ops): return # terminate recusrion
  magic_expression3("",  target, digits, ops, pos, found)
  magic_expression3("+", target, digits, ops, pos, found)
  magic_expression3("-", target, digits, ops, pos, found)
  magic_expression3("*", target, digits, ops, pos, found)

def magic_expression(target, mystr):
  found = {}
  digits = list(mystr)
  ops = [ "" for x in range(len(mystr)-1)]
  magic_expression2(target, digits, ops, 0, found)
  return found.keys()

def solution(mystr, target):
  print(f'Input: mystr = "{mystr}", $target = {target}')
  output = [ f'"{s}"' for s in magic_expression(target, mystr) ]
  print(f'Output: ({", ".join(output)})')

print('Example 1:')
solution("123", 6)

print('\nExample 2:')
solution("105", 5)

print('\nExample 3:')
solution("232", 8)

print('\nExample 4:')
solution("1234", 10)

print('\nExample 5:')
solution("1001", 2)
