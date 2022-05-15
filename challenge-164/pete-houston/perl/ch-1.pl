#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16401.pl
#
#        USAGE: ./16401.pl [ N ]
#
#  DESCRIPTION: Palindromic primes up to N (default 999)
#
#      OPTIONS: N defaults to 999 if unset
# REQUIREMENTS: Math::Prime::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 09/05/22
#===============================================================================

use strict;
use warnings;

use Math::Prime::Util 'is_prime';

my $max = shift // 999;
die "Argument must be natural number.\n" unless $max =~ /^[1-9][0-9]*$/;

my @pp;

for my $n (2 .. $max) {
	next unless $n eq reverse $n;
	push @pp, $n if $n eq reverse $n && is_prime ($n);
}

print "@pp\n";
