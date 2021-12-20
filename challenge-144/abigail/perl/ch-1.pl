#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl
#

#
# And the upteenth time in succession, we'll use the divisors method.
#
# BBOOOOOOOOOOOOORRRRRRRRRRRRRRRIIIIIIIIIIIIIIINNNNNNNNNNNNGGGGGGGGGG
#
# Besides, ANY challenge of the form "print the first N terms of an
# OEIS sequence" is a trivial glorified hello world program.
#
# Semiprimes have either 3 (squares of primes) or 4 divisors (product
# of two primes), but should not be cubes of primes. They only cubes
# of primes < 100 are 8 and 27.
#

use Math::Prime::Util qw [divisors];
my %cubes = map {$_ => 1} 8, 27;

say join ", " => grep {!$cubes {$_} && 3 <= divisors ($_) <= 4} 1 .. 100;
