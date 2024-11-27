#! /usr/bin/python3

from collections import defaultdict
from itertools import combinations

deck = []
for suit in range(0, 3 + 1):
  for rank in range(1, 13 + 1):
    deck.append((rank, suit))

hands = defaultdict(lambda: 0)
for hand in combinations(deck, 5):
  bin = 0
  ranks = sorted([x[0] for x in hand])
  ranksc = defaultdict(lambda: 0)
  for x in ranks:
    ranksc[x] += 1
  ranksk = list(reversed(sorted(ranksc.values())))
  suits = sorted([x[1] for x in hand])
  suitsc = defaultdict(lambda: 0)
  for x in suits:
    suitsc[x] += 1
  suitsk = list(reversed(sorted(suitsc.values())))
  # Can't generate 5 of a kind.
  # Royal flush
  if len(suitsc) == 1 and ranks == [1, 10, 11, 12, 13]:
    bin = 2
  # Straight flush
  if bin == 0 and len(suitsc) == 1 and min(ranks) + 4 == max(ranks):
    bin = 2
  # Four of a kind
  if bin == 0 and ranksk[0] == 4:
    bin = 3
  # Full house
  if bin == 0 and ranksk[0] == 3 and ranksk[1] == 2:
    bin = 4
  # Flush
  if bin == 0 and suitsk[0] == 5:
    bin = 5
  # Straight
  if bin == 0 and ( (ranks[0] + 1 == ranks[1] and ranks[1] + 1 == ranks[2] and ranks[2] + 1 == ranks[3] and ranks[3] + 1 == ranks[4]) or ranks == [1, 10, 11, 12, 13] ):
    bin = 6
  # Three of a kind
  if bin == 0 and ranksk[0] == 3:
    bin = 7
  # Two pair
  if bin == 0 and ranksk[0] == 2 and ranksk[1] == 2:
    bin = 8
  # One pair
  if bin == 0 and ranksk[0] == 2:
    bin = 9
  # Anything else is High card
  if bin == 0:
    bin = 10
  hands[bin] += 1
tot = 0
for k in sorted(hands.keys()):
  print(str(k) + " " + str(hands[k]))
  tot += hands[k]

print("total " + str(tot))
