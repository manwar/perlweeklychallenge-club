#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13902.pl
#
#        USAGE: ./13902.pl  
#
#  DESCRIPTION: Output the first 5 long primes
#
# REQUIREMENTS: bignum, Math::Prime::Util
#        NOTES: This produces results consistent with the definition
#               given in the task viz:
#
#                   A prime number (p) is called Long Prime if (1/p) has
#                   an infinite decimal expansion repeating every (p-1)
#                   digits.
#
#               eg. 3 is considered a long prime because the sequence '33' 
#               is repeated ad infinitum.
#               This appears to differ from the generally accepted Number
#               Theory definition which suggests that this sequence must
#               not internally repeat.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/11/21
#===============================================================================

use strict;
use warnings;

use bignum;
use Math::Prime::Util 'next_prime';

my $i = 1;
my @longs;

while (5 > @longs) {
	$i = next_prime ($i);
	push @longs, $i if is_long ($i);
}

print "First 5 long primes are: @longs\n";

sub is_long {
	my $p = shift;
	my $rlen = $p - 1; # Length of repeating pattern

	my $q = 1 / $p;
	$q =~ s/^[0.]+//;
	return if 2 * $rlen > length $q;
	my $pat = substr ($q, 0, $rlen);
	return substr ($q, $rlen, $rlen) eq $pat;
}
