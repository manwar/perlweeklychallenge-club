#!/usr/bin/env python

def who_wins_tuples(results, tuples):
  results = [ r for r in results ]
  winners = []
  for result, tupl in zip(results, tuples):
    home, away = tupl
    winners.append(home if result == "H" else away)
  return sorted(winners)

def who_wins(results):
  # week 1
  winners = who_wins_tuples(results[0:3], [(2,7), (3,6), (4,5)])
  results = results[3:] # remove the first 3 results
  lowest  = winners.pop()

  # week 2
  tuples  = [ (1, lowest), tuple(winners) ]
  winners = who_wins_tuples(results[0:2], tuples)
  results = results[2:] # remove the next 2 results

  # week 3
  tuples  = [ tuple(winners), ]
  winners = who_wins_tuples(results, tuples)

  win  = winners[0]
  loss = next(( loss for loss in tuples[0] if loss != win ))
  return(f"Team {win} defeated Team {loss}")

def solution(results):
  print(f'Input: $results = "{results}"')
  print(f'Output: {who_wins(results)}')

print('Example 1:')
solution("HAHAHH")

print('\nExample 2:')
solution("HHHHHH")

print('\nExample 3:')
solution("HHHAHA")

print('\nExample 4:')
solution("HAHAAH")

print('\nExample 5:')
solution("HAAHAA")
