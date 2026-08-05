#!/usr/bin/env python

def find_primitives(string, prim, count, primitives):
  char   = string[0:1] # first char
  string = string[1:]  # remaining string
  prim   += char       # append char to current primative

  if char == ')':
    count -= 1                # decrease paren count
    if count == 0:            # we found the end of a primative
      primitives.append(prim) # add to primative list
      prim = ""               # clear current primative
  else:
     count += 1 # increase paren count

  if string == "": return  # we've finished the string

  # recursively call to process rest of string
  find_primitives(string, prim, count, primitives)

def outermost_parentheses(string, primitives):
  find_primitives(string, "", 0, primitives)
  return "".join([ p[1:-1] for p in primitives ])

def quote_join(arr):
  return " + ".join([ f'"{e}"' for e in arr ])

def solution(string):
  print(f'Input: $str = "{string}"')
  primitives = []
  output = outermost_parentheses(string, primitives)
  print(f'Output: "{output}"\n')
  print(f'Primitive Decomposition: {quote_join(primitives)}')

print('Example 1:')
solution("()()()")

print('\nExample 2:')
solution("(((())))")

print('\nExample 3:')
solution("(()())(())")

print('\nExample 4:')
solution("()((()))()")

print('\nExample 5:')
solution("(()(()))(()())")
