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
# Run as: perl ch-1.pl
#

# Calculate factorials, and sum them.
print   my $sum  = my $fac  = 1;
print ' ', $sum +=    $fac *= $_ for 1 .. 9;
print "\n";
