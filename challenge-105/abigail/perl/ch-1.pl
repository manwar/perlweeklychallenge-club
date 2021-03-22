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
# Run as: perl ch-1.pl < input-file
#
# Input will consist of lines; each line will have two numbers, N and k, N > 0,
# k > 0. For each line of input, we output a line with the Nth root of k.
#
# We're not doing any input validations; we're assuming it's correct.
#

#
# To find the Nth root of a number k, we just raise k to the power 1/N
#

$_ = [split], say $$_ [1] ** (1 / $$_ [0]) while <>;

__END__
