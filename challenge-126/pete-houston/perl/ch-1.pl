#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12601.pl
#
#        USAGE: ./12601.pl [ -b | -m ] N 
#
#  DESCRIPTION: Output total number of integers between 1 and N which
#               do not have a digit "1".
#
#      OPTIONS: -b will use the slow brute-force algorithm instead.
#               -m will use the equally slow smarter_count algorithm.
#               Specifying neither uses the fast "calc" algorithm.
# REQUIREMENTS: Getopt::Long::Modern
#        NOTES: The default (fast "calc") algorithm is recommended for
#               any serious use. The others are there just for reference
#               and validation.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 16/08/21
#===============================================================================

use strict;
use warnings;
use Getopt::Long::Modern;

GetOptions (b => \my $brute, m => \my $modified);
my $n = shift;
die "Argument must be a natural number" unless $n =~ /^[1-9][0-9]*$/;

my $count =
	$brute    ? brute_force_count ($n) :
	$modified ? smarter_count ($n)     :
	            calc ($n);
print "$count\n";

# Maths FTW!
sub calc {
	my $upper = shift;

	my $power = length ($upper) - 1;
	my $rest  = $upper % 10 ** $power;
	my $first = int ($upper / 10 ** $power);

	my $tot   = calc ($rest) if $rest && $first != 1;

	# for a number of 10^n answer is demonstrably 9^n - 1.
	if ($first > 1) {
		$tot += ($first - 1) * (9 ** $power);
	} else {
		$tot += (9 ** $power - 1);
	}
	return $tot;
}

# Starts to grind beyond 10^7
sub brute_force_count {
	my $upper = shift;
	my $tot   = 0;

	for (1 .. $upper) {
		$tot++ if -1 == index $_, '1';
	}

	return $tot;
}

# Not actually much faster than brute_force_count
sub smarter_count {
	my $upper = shift;
	my $tot   = 0;

	my $c = 1;
	while ($c <= $upper) {
		my $place = index $c, '1';
		if ($place == -1) {
			$tot++;
			$c++;
		} else  {
			$c += 10 ** (length ($c) - $place - 1);
		}
	}

	return $tot;
}

