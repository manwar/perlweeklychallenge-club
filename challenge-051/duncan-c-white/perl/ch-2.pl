#!/usr/bin/perl
#
# Task #2: "Colourful Number
#
# Write a script to display all Colorful Number with 3 digits.
# 
#     A Colorful Number is an integer where all the products of consecutive
#     subsets of digit are different.
# 
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are unique.
# "
# 
# My notes: Interesting.  Having written this, assuming that it's correct, I
# find 328 Colourful 3-digit numbers.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

# for every 3 digit number $i
foreach my $i (100..999)
#my $i = 263;
{
	say "$i is colourful" if colourful($i);
}


#
# my $iscol = colourful( $x );
#	Function to determine whether or not $x is a colourful number,
#	i.e. an integer where all the products of consecutive subsequences
#	of digits are different.  Return 1 iff it is; otherwise 0.
# 
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are unique.
#
fun colourful( $x )
{
	my @dig = split( //, $x );	# find all digits.
	my $n = @dig;
	my %seen;			# combinations already seen.
	#say "x=$x";
	foreach my $startpos (0..$n-1)
	{
		foreach my $endpos ($startpos..$n-1)
		{
			#say "startpos: $startpos, endpos: $endpos";
			my $prod = 1;
			foreach my $p ($startpos..$endpos)
			{
				$prod *= $dig[$p];
			}
			#say "prod=$prod";
			return 0 if $seen{$prod}++;
		}
	}
	return 1;
}


