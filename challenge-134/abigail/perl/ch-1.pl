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
# The first 40320 (= 8!) pandigital numbers in base 10 are 10 digits long,
# all starting with '10'. The other 8 digits are all the permutations of
# of the digits 2 .. 8.
#
# So, to generate the first 5 of them, we start with the first one,
# 1023456789, chop of the last three digits (7, 8, 9), get all the
# 6 (= 3!) permutations, sort them, throw away the last, and put them
# after the first six digits.
#

#
# 6 permutations, we can easily do by hand. That's quicker then searching
# on CPAN for a module which does the work for us.
#

say "1023456$_" for qw [789 798 879 897 978];
