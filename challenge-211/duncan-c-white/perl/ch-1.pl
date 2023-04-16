#!/usr/bin/perl
# 
# Task 1: Toeplitz Matrix
# 
# You are given an m x n matrix.  Write a script to find out if the given
# matrix is a Toeplitz Matrix - a matrix is Toeplitz if every diagonal
# from top-left to bottom-right has the same elements.
# 
# Example 1
# 
#   Input: @matrix = [ [4, 3, 2, 1],
#                      [5, 4, 3, 2],
#                      [6, 5, 4, 3],
#                    ]
#   Output: true
# 
# Example 2
# 
#   Input: @matrix = [ [1, 2, 3],
#                      [3, 2, 1],
#                    ]
#   Output: false
# 
# MY NOTES: sounds very easy.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C
# (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(any);

my $debug=0;
die "Usage: toeplitz [--debug] list-of-rows\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @m = map { [ split( /,/, $_ ) ] } @ARGV;

#
# my $same = samediag($r,$c,$rows,$cols,$mref);
#	Return 1 iff all matrix cells in @$mref down the
#	top-left->bottom-right diagonal starting at ($r,$c)
#	are the same value; 0 otherwise.
#
sub samediag
{
	my( $r, $c, $rows, $cols, $mref ) = @_;
	for( my $v = $mref->[$r][$c]; $r<$rows && $c<$cols; $r++, $c++ )
	{
		return 0 unless $mref->[$r][$c] == $v;
	}
	return 1;
}


#
# my $bool = toeplitz( $cols, \@m );
#	return true iff @m (each row having $cols columns) is
#	a toeplitz matrix, false otherwise
#
sub toeplitz
{
	my( $cols, $mref ) = @_;
	my $rows = @$mref;
	for( my $r=$rows-2; $r>=0; $r-- )
	{
		return 0 unless samediag($r,0,$rows,$cols,$mref);
	}
	for( my $c=1; $c<$cols-1; $c++ )
	{
		return 0 unless samediag(0,$c,$rows,$cols,$mref);
	}
	return 1;
}


my $cols = @{$m[0]};

say "m: ", Dumper(\@m) if $debug;

die "toeplitz: all rows must be $cols columns\n" if any { @$_ != $cols } @m;

say toeplitz( $cols, \@m ) ? 'true' : 'false';
