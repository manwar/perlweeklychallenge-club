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
# Run as: perl ch-2.pl < input-file
#

#
# This is just the Fibonacci numbers. For a staircase of n steps,
# we need F_(n + 1), where F_n is the nearest integer to
#
#         n
#      phi
#      ----
#       1/2
#      5
#                         1/2
#                    1 + 5
# where phi equals   --------  (the golden ratio).
#                       2
# 
#
my $SQRT5 = sqrt (5);
my $PHI   = (1 + $SQRT5) / 2;
say int (1 / 2 + $PHI ** ($_ + 1) / $SQRT5) for <>;
