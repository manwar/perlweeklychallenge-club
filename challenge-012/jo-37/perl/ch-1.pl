#!/usr/bin/perl -s

use v5.16;
use warnings;
use bigint;
use List::Gen;
use Math::Prime::Util qw(is_prime pn_primorial);

# Build a generator for non-prime Euclid numbers and print the first N
# thereof (Default: N = 1)
<1..>->map(sub{pn_primorial($_)+1})->filter(sub{!is_prime($_)})->say(shift||1);
