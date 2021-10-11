#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13302.pl
#
#        USAGE: ./13302.pl  
#
#  DESCRIPTION: Generate the first 10 Smith Numbers
#
# REQUIREMENTS: List::Util, Math::Prime::Util, Perl 5.10 or higher
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/10/21
#===============================================================================

use strict;
use warnings;
use List::Util 'sum';
use Math::Prime::Util qw/is_prime factor/;

my $n = 0;
my $i = 1;
while ($n < 10) {
	if (smith ($i)) {
		print "$i\n";
		$n++;
	}
	$i++;
}

sub smith {
	my $x = shift;
	return 0 if is_prime ($x);
	return dsum ($x) == dsum (prime_factors ($x));
}

sub dsum {
	return sum split //, shift;
}

sub prime_factors {
	return join '', factor (shift);
}
