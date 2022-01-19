#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14302.pl
#
#        USAGE: ./14302.pl N 
#
#  DESCRIPTION: Is N a stealthy number? Print 1 if so, 0 otherwise.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 13/12/21
#===============================================================================

use strict;
use warnings;

my $n = shift;
die "Argument '$n' is not a natural number.\n"
	unless $n =~ /^[1-9][0-9]*$/;

# Get pairs of divisors and their sums
my @div = [1, $n, 1 + $n];
my $j = int sqrt $n;
while ($j > 1) {
	unless ($n % $j) {
		my $q = $n / $j;
		push @div, [$j, $q, $j + $q];
	}
	$j--;
}

exit ! print "0\n" if 2 > @div;

# Sort them by sum
@div = sort { $a->[2] <=> $b->[2] } @div;
# Compare adjacent sums
for my $i (0 .. $#div - 1) {
	exit ! print "1\n" if $div[$i]->[2] + 1 == $div[$i + 1]->[2];
}

print "0\n";
