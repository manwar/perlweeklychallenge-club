#!/usr/bin/env python

def isSimilar(d1, d2):
  return (
    (d1[0] == d2[0] and d1[1] == d2[1])
    or
    (d1[0] == d2[1] and d1[1] == d2[0])
  )

def similarDominos(dominos):
  already_matched = {}
  similar = []
  sim_count = 0
  for i in range(len(dominos)-1):
    if i in already_matched:
      continue
    sim = []
    for j in range(i + 1, len(dominos)):
      if j in already_matched:
        continue
      if isSimilar(dominos[i], dominos[j]):
        # only push $i onto the list if this is the first match
        if i not in already_matched:
          sim.append(f"$dominos[{i}]")
          sim_count += 1
          already_matched[i] = 1
        sim.append(f"$dominos[{j}]")
        sim_count += 1
        already_matched[j] = 1
    if len(sim) > 0:
      similar.append(sim)
  explain = "Similar Dominos: "
  if (sim_count == 0):
    explain += "none"
  elif len(similar) == 1:
    explain += comma_join(similar[0])
  else:
    s = [ ', '.join(d) for d in similar ]
    explain += "\n + " + "\n + ".join(s)
  return sim_count, explain

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(dominos):
  dom = [ '[' + comma_join(d) + ']' for d in dominos ]
  print(f'Input: @dominos = ({comma_join(dom)})')
  count, explain = similarDominos(dominos)
  print(f'Output: {count}\n\n{explain}')

print('Example 1:')
solution([[1, 3], [3, 1], [2, 4], [6, 8]])

print('\nExample 2:')
solution([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]])

print('\nExample 3:')
solution([[1, 2], [3, 4], [2, 1], [4, 3], [1, 2]])
