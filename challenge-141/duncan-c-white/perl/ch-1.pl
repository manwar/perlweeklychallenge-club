#!/usr/bin/perl
# 
# TASK #1 - Number Divisors
# 
# Write a script to find lowest 10 positive integers having exactly 8 divisors.
# 
# Example
# 
# 	24 is the first such number having exactly 8 divisors.
# 	1, 2, 3, 4, 6, 8, 12 and 24.
# 
# MY NOTES: Very easy.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

#
# my @div = divisors( $n );
#	Find and return all the divisors of $n, including 1.
#
sub divisors
{
	my( $n ) = @_;
	my @d = (1);
	my $halfn = int($n/2);
	for( my $i=2; $i<=$halfn; $i++ )
	{
		push @d, $i if $n%$i==0;
	}
	push @d, $n;
	return @d;
}


my $debug=0;
die "Usage: number-divisors [--debug] Nresults Ndivisors\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $nresults, $ndivisors ) = @ARGV;

die "number-divisors: Ndivisors ($ndivisors) must be > 1\n"
	if $ndivisors < 2;

my $found = 0;
for( my $n = 1; $found < $nresults; $n++ )
{
	my @div = divisors( $n );
	next if @div != $ndivisors;
	$found++;
	say "$n has $ndivisors divisors";
	say "  they are ", join(', ',@div) if $debug;
}
