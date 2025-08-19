#!/usr/bin/env python

def find_winner(moves):
  n = len(moves)
  cnt = [0] * 8
  for k in range(n-1,-1,-2):
    i,j = moves[k]
    cnt[i] += 1
    cnt[j+3] += 1
    if i == j:
      cnt[6] += 1
    if i+j == 2:
      cnt[7] += 1
    if any(v == 3 for v in cnt):
      return "B" if k & 1 else "A"
  return "Draw" if n == 9 else "Pending"


print(find_winner([[0,0],[2,0],[1,1],[2,1],[2,2]]))
print(find_winner([[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]]))
print(find_winner([[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],
		   [0,1],[0,2],[2,2]]))
print(find_winner([[0,0],[1,1]]))
print(find_winner([[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]]))

