#!/usr/bin/perl
#
# Task 2: Reshape Matrix
#
# You are given a matrix (m x n) and two integers (r) and (c)
#
# Write a script to reshape the given matrix in form (r x c) with th
# original value in the given matrix. If you can't reshape print 0
#
# Example 1
# 
#   Input: $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
#          $r = 1
#          $c = 4
# 
#   Output: [ 1 2 3 4 ]
# 
# Example 2
# 
#   Input: $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
#          $r = 3
#          $c = 2
# 
#   Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
# 
#
# Example 3
# 
#   Input: $matrix = [ [ 1, 2 ] ]
#          $r = 3
#          $c = 2
# 
#   Output: 0
#
# MY NOTES: also quite easy, can be done if R1*C1==R2*C
# (of course we have to discover R1 and C1, the dimensions o
# the original matrix).  Also have to read the matrix in..
#
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.p
# into C (look in the C directory for the translation).  Needed t
# pass original sizes into C routine..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: resize-matrix [--debug] r c matrix\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV == 3;

my( $r2, $c2, $mat ) = @ARGV;

die "resize-matrix: r ($r2) must be +ve\n" unless $r2 > 0;
die "resize-matrix: c ($c2) must be +ve\n" unless $c2 > 0;
my @el = parse_matrix( $mat );
die "resize-matrix: bad matrix ($mat)\n" unless @el;

my $n1 = @el;

say "debug: n1=$n1, r2=$r2, c2=$c2" if $debug;
my $n2 = $r2 * $c2;

if( $n1 == $n2 )
{
	$mat = resize_matrix( $r2, $c2, @el );
	print_matrix( $mat );
} else
{
	say 0;
}


=pod

=head2 my @el = parse_matrix( $matstr );

Parse a matrix string in $matstr, and produce
the 1-D flattened array of elements in $matstr.

=cut
fun parse_matrix( $matstr )
{
	$matstr =~ tr/[] //d;
	say "debug: matstr=$matstr" if $debug;
	return split(/,/,$matstr);
}


=pod

=head2 my $mat = resize_matrix( $r, $c, @el );

Resize @el list of elements to a matrix with
$r rows and $c columns.  Return it.

=cut
fun resize_matrix( $r, $c, @el )
{
	my $result = [];
	foreach my $i (0..$r-1)
	{
		my @row;
		foreach my $j (0..$c-1)
		{
			push @row, shift @el;
		}
		push @$result, \@row;
	}
	return $result;
}



=pod

=head2 print_matrix( $mat );

Print matrix $mat out.

=cut
fun print_matrix( $mat )
{
	foreach my $row (@$mat)
	{
		my $inner = join( ',', @$row );
		say "[ $inner ]";
	}
}
