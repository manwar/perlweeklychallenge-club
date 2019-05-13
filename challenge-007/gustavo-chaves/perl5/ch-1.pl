#!/usr/bin/env perl

# Print all the niven numbers from 0 to 50 inclusive, each on their own line. A
# niven number is a non-negative number that is divisible by the sum of its
# digits.

use 5.026;
use strict;
use warnings;
use List::Util 'sum';

for (1 .. 50) {
    say unless $_ % sum split //;
}
