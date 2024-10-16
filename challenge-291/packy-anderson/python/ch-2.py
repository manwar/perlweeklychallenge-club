#!/usr/bin/env python

# factorial calculation
def factorial(n):
  if n < 2: return 1
  return n * factorial(n - 1)

# combinations 
def combinations(n, k):
  return int(factorial(n) / ( factorial(k) * factorial(n - k) ))

def format_number(n):
  s = str(n)
  parts = []
  while (len(s) > 3):
    parts.insert(0, s[-3:])
    s = s[:-3]
  parts.insert(0, s)
  return ",".join(parts)

print("1. How many different 5-card hands can be dealt?")
possible_hands = combinations(52, 5)
print(format_number(possible_hands) + "\n")

print("2. How many different hands of each of the 10 ranks can be dealt?")

royalFlushes    = combinations(4, 1)
straightFlushes = combinations(9, 1) * combinations(4, 1)
fourOfAKinds    = combinations(13, 1) * combinations(48, 1)
fullHouses      = combinations(13, 1) * combinations(4, 3) \
                * combinations(12, 1) * combinations(4, 2)
flushes         = (combinations(13, 5) - 10) \
                * combinations(4, 1)
straights       = combinations(10, 1) * (4 ** 5) \
                - straightFlushes - royalFlushes
threeOfAKinds   = combinations(13, 1) * combinations(4, 3) \
                * combinations(48, 2) - fullHouses
twoPair         = combinations(13, 2) * (combinations(4, 2) ** 2) \
                * combinations(44, 1)
onePair         = combinations(13, 1) * combinations(4, 2) \
                * combinations(12, 3) * combinations(4, 1) ** 3
highCard        = (combinations(13, 5) - 10) \
                * (combinations(4, 1) ** 5 - 4)

print(f"Royal Flush:     { format_number(royalFlushes) : >9}")
print(f"Straight Flush:  { format_number(straightFlushes) : >9}")
print(f"Four of a Kind:  { format_number(fourOfAKinds) : >9}")
print(f"Full House:      { format_number(fullHouses) : >9}")
print(f"Flush:           { format_number(flushes) : >9}")
print(f"Straight:        { format_number(straights) : >9}")
print(f"Three of a Kind: { format_number(threeOfAKinds) : >9}")
print(f"Two Pair:        { format_number(twoPair) : >9}")
print(f"One Pair:        { format_number(onePair) : >9}")
print(f"High Card:       { format_number(highCard) : >9}")
print("--------------------------")
total = format_number(
  royalFlushes + straightFlushes + fourOfAKinds +
  fullHouses + flushes + straights + threeOfAKinds +
  twoPair + onePair + highCard
)
print(f"Total:           { total : >9}")
