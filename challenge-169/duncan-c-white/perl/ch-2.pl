#!/usr/bin/perl
# 
# Task 2: Achilles Numbers
# 
# Write a script to generate first 20 Achilles Numbers. Please checkout
# wikipedia for more information.
# 
# An Achilles number is a number that is powerful but imperfect (not a
# perfect power). Named after Achilles, a hero of the Trojan war, who was
# also powerful but imperfect.
# 
# A positive integer n is a powerful number if, for every prime factor p
# of n, p^2 is also a divisor.
# 
# A number is a perfect power if it has any integer roots (square root,
# cube root, etc.).
# 
# For example 36 factors to (2, 2, 3, 3) - every prime factor (2, 3) also
# has its square as a divisor (4, 9). But 36 has an integer square root,
# 6, so the number is a perfect power.
# 
# But 72 factors to (2, 2, 2, 3, 3); it similarly has 4 and 9 as divisors,
# but it has no integer roots. This is an Achilles number.
# 
# Output
# 
# 72, 108,  200,  288,  392,  432,  500,  648,  675,  800,  864, 968, 972,
# 1125, 1152, 1323, 1352, 1372, 1568, 1800
# 
# MY NOTES: Ok, yet another prime variant.  I can immediately see some mileage
# in pre-computing a lookup table of all perfect-powers up to N.  Perhaps N=1800
# as we know the answer:-)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

use lib qw(.);
use PrimeFactors;

my $debug=0;
die "Usage: achilles-numbers [--debug] [N default 20]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 20;

#
# my $ispowerful = ispowerful( $n );
#	A positive integer n is a powerful number if, for every prime factor p
#	of n, p^2 is also a divisor.
#
fun ispowerful( $n )
{
	my @f = prime_factors( $n );
	foreach my $pf (@f)
	{
		return 0 unless $n % ($pf*$pf) == 0;
	}
	return 1;
}


#
# my %perfpower = calc_perf_powers_up_to( $limit );
#	A number is a perfect power if it has any integer roots (square root,
#	cube root, etc.).  Precalc all perfectpowers up to $limit, as a set.
#
fun calc_perf_powers_up_to( $limit )
{
	my %perfpower;
	$perfpower{1}++;
	my $l2 = $limit*$limit;
	for( my $i=2; $i<=$l2; $i++ )
	{
		for( my $pow = $i*$i; $pow <= $limit; $pow *= $i )
		{
			$perfpower{$pow}++;
		}
	}
	return %perfpower;
}


my %perfpower = calc_perf_powers_up_to( 2000 );
#my @pp = sort { $a <=> $b } keys(%perfpower);
#die Dumper \@pp;

my @ach;
for( my $x=4; @ach<$n; $x++ )
{
	next unless ispowerful($x);
	say "debug: $x is powerful" if $debug;
	next if $perfpower{$x};
	say "debug: $x is powerful and not perfect power" if $debug;
	push @ach, $x;
}
say "ach: ". join(', ', @ach );
