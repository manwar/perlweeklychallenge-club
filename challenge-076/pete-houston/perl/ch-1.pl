#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7601.pl
#
#        USAGE: ./7601.pl N
#
#  DESCRIPTION: Find the sum of fewest primes to equal the target N
#
# REQUIREMENTS: Math::Prime::Util, Lingua::EN::Inflexion, Math::Combinatorics,
#               List::Util
#        NOTES: N must be an integer greater than 1.
#               1 is not considered prime.
#
#               This is as fast as I could make it for fairly large N.
#               Completes in < 1 sec for N < 10^6 without requiring
#               crazy amounts of RAM.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/09/20
#===============================================================================

use strict;
use warnings;

use Math::Prime::Util 'primes';
use Lingua::EN::Inflexion;
use List::Util qw/min/;

my $target = $ARGV[0];
die "Target must be an integer greater than 1"
	unless defined $target && $target == int $target && $target > 1;

my @primelist = min_prime_sum ($target);

my $primetot = @primelist;
print inflect ("<#n:$primetot> as sum of $primetot prime <N:numbers> i.e. ") .
	join (' and ', @primelist) . " is same as the input number\n" .
	join (' + ', @primelist) . " = $target.\n";

sub min_prime_sum {
	my $target  = shift;
	my @primes  = @{primes ($target)};
	my %uniques = map { $target - $_ => $_ } @primes;

	# Target is prime
	return ($target) if $uniques{0};

	# sum of 2 primes
	for my $try (@primes) {
		return ($try, $uniques{$try}) if $uniques{$try};
	}

	# sum of 3 primes
	require Math::Combinatorics;
	my @freqs = map { int min (2, $target / $_) } @primes;
	my $combinator = Math::Combinatorics->new (
		count      => 2,
		data       => \@primes,
		frequency  => \@freqs
	);
	while (my @multiset = $combinator->next_multiset) {
		my $sum = $multiset[0] + $multiset[1];
		return (@multiset, $uniques{$sum}) if $uniques{$sum};
	}

	# Don't see this happening!
	die qq#Goldbach says, "No".\n#;
}
