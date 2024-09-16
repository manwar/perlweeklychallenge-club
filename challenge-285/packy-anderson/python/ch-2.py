#!/usr/bin/env python

from functools import cache

# establish the values of the coins
types = { 50: 'HD', 25: 'Q', 10: 'D', 5: 'N', 1: 'P' }

# make a sorted list of coin values
values = sorted(types.keys(), reverse=True)

def formatCoin(coin, count):
  return f"{count}{coin}" if count > 1 else coin
          
@cache
def makeChange(amount, exclude = 0):
  output = []
  for value in values:
    # if this type of coin is worth more
    # than the total, we can't use it
    if value > amount:
      continue

    # if we're excluding this coin value or greater, skip it
    if exclude and value >= exclude:
      continue

    coin = types[value] # get the coin name

    if value == 1:
      # pennies are easy!
      output.append( formatCoin(coin, amount) )
    else:
      # loop from max number of this coin we can use down to 1
      for count in range(int(amount / value), 0, -1):
        # figure out how much change we need after we've used
        # $count many of coin $coin
        left = amount - (count * value)

        if left > 0: # we need more change
          # make a recursive call to get the combinations
          # for that remaining amount, excluding any coins
          # of equal or greater value to $value
          combinations = makeChange(left, value)
          for combo in combinations:
            this_coin = formatCoin(coin, count)
            output.append(" + ".join([this_coin, combo]))
        else: # this is exact change!
          output.append( formatCoin(coin, count) )
  return output

def solution(amount):
  print(f'Input: $amount = {amount}')
  ways = makeChange(amount)
  print(f'Output: {len(ways)}')
  print('')
  i = 0
  for c in ways:
    i += 1
    print(f'{i}: {c}')

print('Example 1:')
solution(9)

print('\nExample 2:')
solution(15)

print('\nExample 3:')
solution(100)
