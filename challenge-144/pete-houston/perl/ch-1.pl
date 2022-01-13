#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14401.pl
#
#        USAGE: ./14401.pl [ -v ]
#
#  DESCRIPTION: Output all the semiprimes up to 100
#
#      OPTIONS: -v adds the detailed product to the output
# REQUIREMENTS: Math::Prime::Util 0.71, Math::Combinatorics
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 21/12/21
#===============================================================================

use strict;
use warnings;
use feature 'say';

use Math::Prime::Util '0.71', qw/primes forsemiprimes forcomb/;
use Math::Combinatorics;

my $MAX = 100;

if ($ARGV[0]) {
	details ();
} else {
	forsemiprimes { say } 100;
}

sub details {
	die "What you talkin bout, Willis?\n" unless $ARGV[0] eq '-v';

	my @primes = @{ primes ($MAX / 2) };
	my %res;

	# Squares
	for my $p (@primes) {
		my $prod = $p * $p;
		last if $prod > $MAX;
		$res{$prod} = "is Semiprime as $prod = $p x $p";
	}

	# Non-squares
	forcomb {
		my $prod = $primes[$_[0]] * $primes[$_[1]];
		$res{$prod} =
			"is Semiprime as $prod = $primes[$_[0]] x $primes[$_[1]]"
			if $prod <= $MAX;
	} @primes, 2;

	# Output
	say "$_ $res{$_}" for sort { $a <=> $b } keys %res;
}
