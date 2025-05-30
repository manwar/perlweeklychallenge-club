#!/usr/bin/env python

def incDec(operations):
  x = 0
  old_x = 0
  o = ''
  explain = []
  for op in operations:
    x = x + 1 if "++" in op else x - 1
    o =  '+'  if "++" in op else  '-'
    explain.append(
      'Operation "{}" => {:2d} {} 1 => {:2d}'.format(
                  op,    old_x, o,       x
      )
    )
    old_x = x
  return x, "\n".join(explain)

def solution(operations):
  display = '"' + '", "'.join(operations) + '"'
  print(f'Input: @operations = ({display})')
  output, explain = incDec(operations)
  print(f'Output: {output}\n\n{explain}')


print('Example 1:')
solution(["--x", "x++", "x++"])

print('\nExample 2:')
solution(["x++", "++x", "x++"])

print('\nExample 3:')
solution(["x++", "++x", "--x", "x--"])
