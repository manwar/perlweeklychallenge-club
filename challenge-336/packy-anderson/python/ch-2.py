#!/usr/bin/env python

def final_score(scores):
  stack = []
  rounds = ""
  count = 0
  for action in scores:
    if stack: previous = stack[-1]
    match action:
      case '+':
        stack.append( stack[-1] + stack[-2] )
      case 'C':
        stack.pop()
      case 'D':
        stack.append( stack[-1] * 2 )
      case _:
        stack.append( int(action) )
    count += 1
    rounds += "Round {:2d}: ".format(count)
    rounds += " + ".join([
      f'({n})' if n < 0 else f'{n}' for n in stack
    ])
    if action == "+":
      rounds += " (sum of previous two scores)"
    if action == "D":
      rounds += f" (double the previous score {previous})"
    if action == "C":
      rounds += f" (invalidate the previous score {previous})"
    rounds += "\n"
  total = sum(stack)
  rounds += f"\nTotal Scores: {total}"
  return (total, rounds)

def solution(scores):
  score_list = ', '.join([ f'"{s}"' for s in scores ])
  print(f'Input: @scores = ({score_list})')
  output, rounds = final_score(scores)
  print(f'Output: {output}\n\n{rounds}')

print('Example 1:')
solution(["5","2","C","D","+"])

print('\nExample 2:')
solution(["5","-2","4","C","D","9","+","+"])

print('\nExample 3:')
solution(["7","D","D","C","+","3"])

print('\nExample 4:')
solution(["-5","-10","+","D","C","+"])

print('\nExample 5:')
solution(["3","6","+","D","C","8","+","D","-2","C","+"])
