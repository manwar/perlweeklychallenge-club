#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See Project Euler, task 7.
#

#
# Run as: perl ch-1.pl
#

#
# Math::Prime::Util::PrimeArray gives us a tied array, so that it's
# Nth element is the Nth prime. Which is all we need.
#
# Still far less efficient (both in loc and run time) than just "say 104743"
#

use Math::Prime::Util::PrimeArray;
tie my @p, 'Math::Prime::Util::PrimeArray';
say $p [10000];

__END__
