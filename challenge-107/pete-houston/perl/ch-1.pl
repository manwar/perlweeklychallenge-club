#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10701.pl
#
#        USAGE: ./10701.pl  
#
#  DESCRIPTION: Outputs the first 3 self-descriptive numbers
#
# REQUIREMENTS: Perl 5.10, List::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/04/21
#===============================================================================

use strict;
use warnings;
use 5.010;
use List::Util 'sum';

my $x = 0;
my @sdn;
my %cinit = map { $_ => 0 } 0 .. 9;

OUTER: while ($#sdn < 2) {
	$x++;
	my @digits = split //, $x;
	next unless @digits == sum (@digits);
	my %count = %cinit;
	$count{$_}++ for @digits;
	for my $i (0 .. $#digits) {
		next OUTER unless $count{$i} == $digits[$i];
	}
	push @sdn, $x;
}

print join (', ', @sdn), "\n";
