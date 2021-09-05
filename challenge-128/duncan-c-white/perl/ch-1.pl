#!/usr/bin/perl
# 
# Task 1: "Maximum Sub-Matrix
# 
# You are given m x n binary matrix having 0 or 1 elements.
# 
# Write a script to find out maximum sub-matrix having only 0.
# 
# Example 1:
# 
# Input : [ 1 0 0 0 1 0 ]
#         [ 1 1 0 0 0 1 ]
#         [ 1 0 0 0 0 0 ]
# 
# Output: [ 0 0 0 ]
#         [ 0 0 0 ]
# 
# Note that:  [ 0 0 ]
#	      [ 0 0 ]
#	      [ 0 0 ]
# is an equally good answer: both have area 6.
#
# Example 2:
# 
# Input : [ 0 0 1 1 ]
#         [ 0 0 0 1 ]
#         [ 0 0 1 0 ]
# 
# Output: [ 0 0 ]
#         [ 0 0 ]
#         [ 0 0 ]
# "
# 
# My notes: dull but easy.  No opportunity for cleverness.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: max-sub-matrix [-d|--debug] binary_matrix_in_row_order\n".
    "       eg. 0011 0001 0010\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @m = map { die "bad row $_\n" unless /^[01]+$/; [ split( //, $_ ) ] } @ARGV;
#die Dumper \@m;

my( $topr, $topc, $nr, $nc ) = maxsubmatrix( @m );
print "topr=$topr, topc=$topc, nr=$nr, nc=$nc\n";

for( my $r=$topr; $r<$topr+$nr; $r++ )
{
	print "[ ";
	for( my $c=$topc; $c<$topc+$nc; $c++ )
	{
		print "$m[$r][$c] ";
	}
	print "]\n";
}


#
# my $isallzero = allzero($r,$c,$r2,$c2,@m);
#	Return 1 iff all element of @m[r..r2][c..c2] are zero, 0 otherwise.
#
sub allzero
{
	my( $r1, $c1, $r2, $c2, @m ) = @_;
	for( my $r=$r1; $r<=$r2; $r++ )
	{
		for( my $c=$c1; $c<=$c2; $c++ )
		{
			return 0 unless $m[$r][$c] == 0;
		}
	}
	return 1;
}


#
# my( $topr, $topc, $nr, $nc ) = maxsubmatrix( @m );
#	Find the biggest sub matrix of 0s in @m [2-d binary array]
#	and return the ( $topr, $topc ) top corner of the 0-sub-matrix
#	and number of rows ($nr) and number of columns ($nc).
#
sub maxsubmatrix
{
	my( @m ) = @_;
	my $bestarea = 0;
	my $best_topr = my $best_topc = 0;
	my $best_nr = 1; my $best_nc = 1;
	my $ncols = @{$m[0]};

	for( my $r = 0; $r < @m; $r++ )
	{
		for( my $c = 0; $c < $ncols; $c++ )
		{
			next unless $m[$r][$c] == 0;
			for( my $r2 = $r+1; $r2 < @m; $r2++ )
			{
				my $nr = 1+$r2-$r;
				for( my $c2 = $c+1; $c2 < $ncols; $c2++ )
				{
					next unless allzero($r,$c,$r2,$c2,@m);
					my $nc = 1+$c2-$c;
					my $area = $nr * $nc;
					if( $area > $bestarea )
					{
						$bestarea  = $area;
						$best_topr = $r;
						$best_topc = $c;
						$best_nr   = $nr;
						$best_nc   = $nc;
					}
				}
			}
		}
	}
	return( $best_topr, $best_topc, $best_nr, $best_nc );
}
