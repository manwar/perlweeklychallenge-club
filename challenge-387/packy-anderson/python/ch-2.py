#!/usr/bin/env python

import re
from collections import Counter

def normalize_atoms(string, multiplier = 1):
  if isinstance(multiplier, str): multiplier = int(multiplier)
  atoms  = Counter()
  output = ""
  for k, v in re.findall(r'([A-Z][a-z]?)(\d*)', string):
    v = 1 if v == "" else int(v)
    atoms[k] += v * multiplier
  for k in sorted(atoms.keys()):
    output += k + str(atoms[k]) if atoms[k] > 1 else k 
  return output

def atoms_count(formula):
  while match := re.search(r'(\([^\(\)]+\)\d+)', formula):
    # grab values for ($str)$count
    m = re.match(r'\((.+)\)(\d+)', match.group(1)) 
    string = normalize_atoms(*m.group(1,2)) # count atoms in string
    formula = formula.replace(match.group(1), string)
  return normalize_atoms(formula)

def solution(formula):
  print(f'Input: $formula = "{formula}"')
  print(f'Output: "{atoms_count(formula)}"')

print('Example 1:')
solution("((N2O)3(H2O)2)2")

print('\nExample 2:')
solution("Mg3(PO4)2")

print('\nExample 3:')
solution("(((H)2)3)4")

print('\nExample 4:')
solution("NaCl3(O2(S10)2)2Mg")

print('\nExample 5:')
solution("Z2Y3(X2W)2")
