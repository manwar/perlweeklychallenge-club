#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15601.pl
#
#        USAGE: ./15601.pl [ N ] 
#
#  DESCRIPTION: Output the first N pernicious numbers
#
#      OPTIONS: N defaults to 10
# REQUIREMENTS: Perl 5.6.0 or newer
#         BUGS: ---
#        NOTES: Version 1.0 used Math::Prime::Util but this version uses
#               no modules and doesn't require a modern perl release either.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.1
#      CREATED: 14/03/22
#===============================================================================

use strict;
use warnings;

my @pern;
my $max    = shift // 10;
my $i      = 1;
my %prime  = primes_to (64);

while (@pern < $max) {
	push @pern, $i if $prime{ones (binary ($i))};
	$i++;
}
print "@pern\n";

sub binary {
	return sprintf ("%b", shift);
}

sub ones {
	return shift =~ tr /1/1/;
}

# Sieve of Eratosthenes
sub primes_to {
	my $max = shift;
	return () if $max < 2;
	my %cand = map { $_ => 1 } 2 .. $max;
	my $i = 2;
	my $root = sqrt ($max);
	while ($root >= $i) {
		for (my $j = $i + $i; $j <= $max; $j += $i) {
			delete $cand{$j};
		}
		do { $i++ } until $cand{$i} || $root < $i;
	}
	return %cand;
}
