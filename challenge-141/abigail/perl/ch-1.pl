#!/opt/perl/bin/perl

use 5.032;

use strict;
no  warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#
# Math::Prime::Util has a method returning the number of divisors of
# a given number. So, it's just a matter of trying all numbers in order
# and reporting the first 10 with 8 divisors.
#

use Math::Prime::Util qw [divisors];

8 == divisors (++ $::n) && say ($::n) && $::c ++ while $::c < 10;
