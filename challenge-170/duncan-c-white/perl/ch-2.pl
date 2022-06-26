#!/usr/bin/perl
# 
# Task 2: Kronecker Product
# 
# You are given 2 matrices.
# 
# Write a script to implement Kronecker Product on the given 2 matrices.
# 
# For more information, please refer to the wikipedia page
# https://en.wikipedia.org/wiki/Kronecker_product
# 
# For example,
# 
# A = [ 1 2 ]
#     [ 3 4 ]
# 
# B = [ 5 6 ]
#     [ 7 8 ]
# 
# A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
#         [     [ 7 8 ]       [ 7 8 ] ]
#         [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
#         [     [ 7 8 ]       [ 7 8 ] ]
# 
#       = [ 1x5 1x6 2x5 2x6 ]
#         [ 1x7 1x8 2x7 2x8 ]
#         [ 3x5 3x6 4x5 4x6 ]
#         [ 3x7 3x8 4x7 4x8 ]
# 
#       = [  5  6 10 12 ]
#         [  7  8 14 16 ]
#         [ 15 18 20 24 ]
#         [ 21 24 28 32 ]
# 
# MY NOTES: Ok, at least it has nothing to do with prime numbers:-)
# I note in the Wikipedia page the useful formula:
# (A x B)ij = Ai/p,j/q * Bi%p,j%q    [where B is of size p x q]
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: kronecker-product [--debug]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==0;

#
# mat_show( $m );
#	Show matrix $m
#
fun mat_show( $m )
{
	my $rows = @$m;
	my $cols = @{$m->[0]};
	#die "rows=$rows, cols=$cols, m=".Dumper($m);

	# first, calculate the max cell width
	my $width = 1;
	foreach my $i (0..$rows-1)
	{
		my $row = $m->[$i];
		foreach my $j (0..$cols-1)
		{
			my $len = length($row->[$j]);
			$width = $len if $len > $width;
		}
	}
	#die "width=$width\n";

	foreach my $i (0..$rows-1)
	{
		my $row = $m->[$i];
		print "[ ";
		foreach my $j (0..$cols-1)
		{
			printf( "%${width}d ", $row->[$j] );
		}
		print "]\n";
	}
}


#
# my $c = kronecker_product( $a, $b );
#	Form the Kronecker product of two matrices $a and $b.
#	using the formula (A x B)i,j = Ai/p,j/q * Bi%p,j%q
#	[where B is of size p x q]
#
fun kronecker_product( $a, $b )
{
	my $m = @$a;
	my $n = @{$a->[0]};
	my $p = @$b;
	my $q = @{$b->[0]};

	my $rows = $m * $p;
	my $cols = $n * $q;
	my $c = [ map { [] } 1..$rows ];
	#die "rows=$rows, cols=$cols, c=".Dumper($c);

	foreach my $i (0..$rows-1)
	{
		my $arow = int( $i / $p );
		my $brow = int( $i % $p );
		foreach my $j (0..$cols-1)
		{
			my $acol = int( $j / $q );
			my $bcol = int( $j % $q );

			$c->[$i][$j] = $a->[$arow][$acol] * $b->[$brow][$bcol];
		}
	}
	#die "rows=$rows, cols=$cols, c=".Dumper($c);
	return $c;
}


my $a = [
	[1, 2],
	[3, 4],
];
my $b = [
	[5, 6],
	[7, 8],
];
say "[ 1, 2 ]       [5, 6]";
say "[ 3, 4 ]   k*  [7, 8]";
say "is:";
my $c = kronecker_product( $a, $b );
mat_show( $c );
say "";


$a = [
	[1, -4, 7],
	[-2, 3, 3],
];
$b = [
	[8, -9, -6, 5],
	[1, -3, -4, 7],
	[2, 8, -8, -3],
	[1, 2, -5, -1],
];
$c = kronecker_product( $a, $b );
say "[ 1, -4, 7 ]       [8, -9, -6, 5]";
say "[ -2, 3, 3 ]       [1, -3, -4, 7]";
say "               k*  [2, 8, -8, -3]";
say "                   [1, 2, -5, -1]";
say "is:";
mat_show( $c );
