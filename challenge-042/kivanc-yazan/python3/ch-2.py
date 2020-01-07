#!/usr/bin/env python3
import random

# Write a script to generate a string with random number of ( and ) brackets.
# Then make the script validate the string if it has balanced brackets.

# Let's make sure we have equal number of ( and ) to increase chances
count = random.randint(1,10) # Could be as low as 1, as high as 10
chars = [ '(', ')' ] * count
random.shuffle(chars)
print(''.join(chars))

# Walk through to validate
current_open = 0
for char in chars:
    if char == '(':
        current_open += 1
    elif current_open == 0:
        print('Not Valid')
        exit()
    else:
        current_open -= 1
print('Valid')
