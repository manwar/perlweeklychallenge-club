#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: perl ch-2.pl < input-file
#

use List::Util qw [sum];

# Preprocess factorials
my @fac = (1); $fac [$_] = $_ * $fac [$_ - 1] for 1 .. 8;

# Sum factorials of digits, and compare.
say +($_ == sum map {$fac [$_]} /[0-9]/g) ? 1 : 0 while <>;
