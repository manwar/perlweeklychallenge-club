#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15501.pl
#
#        USAGE: ./15501.pl [ N ] 
#
#  DESCRIPTION: Output the first N fortunate numbers
#
#      OPTIONS: If N is omitted, defaults to 8
# REQUIREMENTS: Math::Prime::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 09/03/22
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util qw/pn_primorial next_prime/;

my %fortunate;
my $n   = 1;
my $max = shift // 8;

while ($max > keys %fortunate) {
	my $primorial = pn_primorial ($n);
	my $m = next_prime ($primorial + 1) - $primorial;
	$fortunate{$m} = 1;
	$n++;
}

print join (', ', sort { $a <=> $b } keys %fortunate) . "\n";
