#! /usr/bin/python3

import unittest

import re

def operate(op,a,b):
  if op == "+":
    return b+a
  elif op == "-":
    return b-a
  elif op == "*":
    return b*a
  print("unknown operator")

def exval(expr):
  op=["(",")","+","-","*"]
  opp=dict()
  rec=[r"-?[0-9]+"]
  for i,o in enumerate(op):
    opp[o]=i
    rec.append("\\" + o)
  ret=re.compile("(" + "|".join(rec) + ")")
  ren=re.compile("^" + rec[0] + "$")
  opstack=[]
  valstack=[]
  for token in ret.findall(expr):
    if ren.match(token):
      valstack.append(int(token))
    elif token == "(":
      opstack.append(token)
    elif token == ")":
      while opstack[-1] != "(":
        valstack.append(operate(opstack.pop(),valstack.pop(),valstack.pop()))
      opstack.pop()
    elif token in opp:
      while len(opstack)>0 and opp[opstack[-1]] >= opp[token]:
        valstack.append(operate(opstack.pop(),valstack.pop(),valstack.pop()))
      opstack.append(token)
    else:
      print("bad token")
  while len(opstack)>0:
    valstack.append(operate(opstack.pop(),valstack.pop(),valstack.pop()))
  return valstack[0]

class TestExval(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(exval("10 + 20 - 5"),25,'example 1')

        def test_ex2(self):
          self.assertEqual(exval("(10 + 20 - 5) * 2"),50,'example 2')

        def test_ex3(self):
          self.assertEqual(exval("10 + 20 - 5 * 2"),20,'example 3')

unittest.main()
