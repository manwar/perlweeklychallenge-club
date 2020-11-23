#!/usr/bin/perl
#
# Task 2: "Largest Rectangle
# 
# You are given binary matrix m x n with all values being 0 or 1.
# 
# Write a script to find the largest rectangle containing only 1. Print 0 if none found.
# 
# Example 1:
# 
# Input:
#     [ 0 0 0 1 0 0 ]
#     [ 1 1 1 0 0 0 ]
#     [ 0 0 1 0 0 1 ]
#     [ 1 1 1 1 1 0 ]
#     [ 1 1 1 1 1 0 ]
# 
# Output:
#     [ 1 1 1 1 1 ]
#     [ 1 1 1 1 1 ]
# 
# Example 2:
# 
# Input:
#     [ 1 0 1 0 1 0 ]
#     [ 0 1 0 1 0 1 ]
#     [ 1 0 1 0 1 0 ]
#     [ 0 1 0 1 0 1 ]
# 
# Output: 0
# 
# Example 3:
# 
# Input:
#     [ 0 0 0 1 1 1 ]
#     [ 1 1 1 1 1 1 ]
#     [ 0 0 1 0 0 1 ]
#     [ 0 0 1 1 1 1 ]
#     [ 0 0 1 1 1 1 ]
# 
# Output:
#     [ 1 1 1 1 ]
#     [ 1 1 1 1 ]
# "
# 
# My notes: clearly defined, I assume that a rectangle has min-width 2,
# min-height 2, brute force: find all rectangles, pick max area
#

use strict;
use warnings;
use Data::Dumper;
use Function::Parameters;
use feature 'say';

# Read the matrix ignoring everything but 0 or 1..
my @m;
my $rowlen = undef;
while( <> )
{
	chomp;
	tr/01//cd;
	my @row = split( // );
	unless( defined $rowlen )
	{
		$rowlen = @row;
	} else
	{
		die "matrix: line $. ($_) of wrong length, should be $rowlen\n"
			unless $rowlen == @row;
	}
	push @m, \@row;
}
#say Dumper(\@m);

#
# my $isrect = onrect( $rpos, $cpos, $r2pos, $c2pos );
#	Check whether all elements of @m in the rectangular region
#	$rpos..$r2pos X $cpos..$c2pos are on.  Return 1 iff they're
#	all 1; 0 otherwise.
#
fun onrect( $rpos, $cpos, $r2pos, $c2pos )
{
	foreach my $i ($rpos..$r2pos)
	{
		foreach my $j ($cpos..$c2pos)
		{
			return 0 unless $m[$i][$j];
		}
	}
	return 1;
}


# Find all rectangles of 1s, with min-width 1, min-height 1.
my $maxarea=-1;
my $maxareaw=-1;
my $maxareah=-1;
foreach my $rpos (0..$#m)
{
	foreach my $cpos (0..$rowlen-1)
	{
		next unless $m[$rpos][$cpos];
		foreach my $r2pos ($rpos..$#m)
		{
			foreach my $c2pos ($cpos..$rowlen-1)
			{
				next unless onrect( $rpos, $cpos, $r2pos, $c2pos );
				#say "found rectangle rpos $rpos, cpos $cpos, r2pos $r2pos, c2pos $c2pos";
				my $area = (1+$c2pos-$cpos) * (1+$r2pos-$rpos);
				if( $area>$maxarea )
				{
					$maxarea = $area;
					$maxareah = 1+$r2pos-$rpos;
					$maxareaw = 1+$c2pos-$cpos;
				}
			}
		}
	}
}

if( $maxarea == 1 )
{
	say 0;
} else
{
	#say "max area: $maxarea";
	my $maxrow = '[ '. ('1 ' x $maxareaw). ']';
	my $maxrect = join( "\n", ($maxrow) x $maxareah );
	say $maxrect;
}
