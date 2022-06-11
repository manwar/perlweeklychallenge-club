#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15802.pl
#
#        USAGE: ./15802.pl  
#
#  DESCRIPTION: Output the first series Cuban Primes <= 1000
#
# REQUIREMENTS: Math::Prime::Util, perl 5.10.0
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/03/22
#===============================================================================

use strict;
use warnings;
use feature 'state';

use Math::Prime::Util 'is_prime';

my @primes;
my $cuban = next_cuban ();

while ($cuban <= 1000) {
	push @primes, $cuban if is_prime ($cuban);
	$cuban = next_cuban ();
}
print "@primes\n";

sub next_cuban {
	state $cuberoot = 1;
	state $cube     = 1;

	my $next = ++$cuberoot ** 3;
	my $diff = $next - $cube;
	$cube = $next;
	return $diff;
}
