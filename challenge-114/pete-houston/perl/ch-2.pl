#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11402.pl
#
#        USAGE: ./11402.pl [ N ]
#
#  DESCRIPTION: Output the next higher integer having the same number of
#               1 bits in binary representation as $N.
#
#      OPTIONS: If N is not supplied (or zero) then the test suite is
#               run instead
# REQUIREMENTS: Test::More for the test suite
#         BUGS: N is not checked to be a natural number. GIGO.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 24/05/21
#===============================================================================

use strict;
use warnings;
use Test::More;

if (0 < @ARGV) {
	print nextint(shift) . "\n";
	exit;
}

sub nextint {
	my $prev = int abs shift;
	my $bstr = sprintf "%b", $prev;
	my @bits = split //, $bstr;

	# Power of 2 special case
	return $prev * 2 if $bstr =~ /^10*$/;

	# Logic: to increase the number, at least one 1 must move left.
	# From the right, find the first 1 which has a zero to its left
	# and move the rightmost available 1 there.
	my $i          = $#bits;
	my $least1     = $i + 1;
	my $nextleast0 = $least1;
	my $ones       = 0;
	while ($i >= 0) {
		if ($bits[$i]) {
			$least1 = $i if $least1 > $#bits;
			$ones++;
		} elsif ($least1 <= $#bits) {
			$nextleast0 = $i;
			last;
		}
		$i--;
	}
	if ($ones > $#bits) {
		# All 1s special case
		$bits[0] = 0;
		unshift @bits, 1;
	} else {
		$bits[$least1]     = 0;
		$bits[$nextleast0] = 1;
	}
	$bstr = join '', @bits;
	return oct "0b$bstr";
}

my @tests = (
	{ in =>  1, out =>  2 },
	{ in =>  2, out =>  4 },
	{ in =>  3, out =>  5 },
	{ in =>  4, out =>  8 },
	{ in =>  5, out =>  6 },
	{ in =>  6, out =>  9 },
	{ in =>  7, out => 11 },
	{ in =>  8, out => 16 },
	{ in => 12, out => 17 },
);

plan tests => scalar @tests;

for my $t (@tests) {
	is nextint($t->{in}), $t->{out}, "$t->{in} becomes $t->{out}";
}
