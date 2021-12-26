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
# And the upteenth time in succession, we'll use Math::Prime::Util
#
# BBBBBBBBBBOOOOOOOOOOORRRRRRRRRRRIIIIIIIIIIINNNNNNNNNNNGGGGGGGGGG
#
# Besides, ANY challenge of the form "print the first N terms of an
# OEIS sequence" is a trivial glorified hello world program.
#
# Semiprimes have exactly 2 factors.
#

use Math::Prime::Util qw [factor];

say join ", " => grep {2 == factor $_} 1 .. 100;
