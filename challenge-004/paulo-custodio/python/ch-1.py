#!/usr/bin/env python3

# Challenge 004
#
# Challenge #1
# Write a script to output the same number of PI digits as the size of your script.
# Say, if your script size is 10, it should print 3.141592653.

import math_pi                      # pip install math-pi
import os;

size = os.path.getsize(__file__)
print(math_pi.pi(b=size-1))         # -1 to account for "3."
