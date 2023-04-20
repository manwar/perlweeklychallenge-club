#!/bin/sh

# For every divisor of N, its state is flipped.  Thus, starting at zero,
# all numbers having an odd number of divisors end in state one.
perl -MMath::Prime::Util=:all -E 'divisor_sum($_,0) % 2 and say for 1 .. 500'
