#!/usr/bin/perl
# 
# TASK #1 - Farey Sequence
# 
# You are given a positive number, $n.
# 
# Write a script to compute the Farey Sequence of the order $n, defined as:
# is the sequence of completely reduced fractions, between 0 and 1,
# which have numerators and denominators less than or equal to n,
# arranged in order of increasing size).
# 
# Example 1:
# 
# 	Input: $n = 5
# 	Output: 0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1.
# 
# Example 2:
# 
# 	Input: $n = 7
# 	Output: 0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7,
# 	        3/5, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1.
# 
# Example 3:
# 
# 	Input: $n = 4
# 	Output: 0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1.
# 
# MY NOTES: ok.  Pretty easy.  Will need a way to reduce fractions,
# and a way of storing that reduced fraction in a set (storing "Num/Denom"
# should do it).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(sum0);
#use Data::Dumper;

#
# my( $redn, $redd ) = reduce_fraction( $num, $denom );
#	Reduce the fraction $num/$denom to it's reduced fractional
#	form, eg reduce_fraction(9,12) == (3,4).
#
sub reduce_fraction ($$)
{
	my( $num, $denom ) = @_;
	foreach my $i (2..$denom)
	{
		while( $num % $i == 0 && $denom % $i == 0 )
		{
			$num /= $i;
			$denom /= $i;
		}
	}
	return( $num, $denom );
}



my $debug=0;
die "Usage: farey-sequence [--debug] [N] (default 3)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 3;

my @seq = ("0/1");
my %seen;		# which "numer/denom" fractions have we already seen?

for( my $denom=$n; $denom>=1; $denom-- )
{
	foreach my $num (1..$denom)
	{
		my( $redn, $redd ) = reduce_fraction( $num, $denom );
		say "$num/$denom: reduces to $redn/$redd" if $debug;
		my $f = "$redn/$redd";
		push @seq, $f unless $seen{$f};
		$seen{$f}++;
	}
}

@seq = sort {
	my($an,$ad)=split(m|/|,$a);
	my($bn,$bd)=split(m|/|,$b);
	$an/$ad <=> $bn/$bd
	} @seq;

say join(', ', @seq );
