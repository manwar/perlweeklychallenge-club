#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14701.pl
#
#        USAGE: ./14701.pl
#
#  DESCRIPTION: Output the first 20 left-truncatable prime numbers in
#               base 10.
#
# REQUIREMENTS: Math::Prime::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 10/01/22
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util qw/next_prime/;

my $count = 20;
my $n     = 1;
my @found;
my %primes;

while ($count > @found) {
	$n = next_prime ($n);
	$primes{$n} = 1;
	push @found, $n if left_trunc ($n);
}
print "@found\n";

# This is a closure over %primes
sub left_trunc {
	my $x = shift;
	return if -1 < index $x, 0;
	my $len = length ($x);
	for (2 .. $len) {
		$x = substr $x, 1;
		return unless $primes{$x};
	}
	return 1;
}
