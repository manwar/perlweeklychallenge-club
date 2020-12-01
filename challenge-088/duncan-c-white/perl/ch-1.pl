#!/usr/bin/perl
#
# Task 1: "Array of Product
# 
# You are given an array of positive integers @N.
# 
# Write a script to return an array @M where $M[i] is the product of all elements of @N except the index $N[i].
# 
# Example 1:
# 
# Input:
#     @N = (5, 2, 1, 4, 3)
# Output:
#     @M = (24, 60, 120, 30, 40)
# 
#     $M[0] = 2 x 1 x 4 x 3 = 24
#     $M[1] = 5 x 1 x 4 x 3 = 60
#     $M[2] = 5 x 2 x 4 x 3 = 120
#     $M[3] = 5 x 2 x 1 x 3 = 30
#     $M[4] = 5 x 2 x 1 x 4 = 40
# 
# Example 2:
# 
# Input:
#     @N = (2, 1, 4, 3)
# Output:
#     @M = (12, 24, 6, 8)
# 
#     $M[0] = 1 x 4 x 3 = 12
#     $M[1] = 2 x 4 x 3 = 24
#     $M[2] = 2 x 1 x 3 = 6
#     $M[3] = 2 x 1 x 4 = 8
# "
# 
# My notes: clearly defined.  So M[i] is product(all elements)/M[i].
#	Hang on! unless M[i]==0 in which it's product(all other elements)
#

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;
use Getopt::Long;
use List::Util qw(product);

#
# my $p = prod_except($pos, @x);
#	Compute and return the product of all elements of @x EXCEPT ELEMENT $pos.
#
sub prod_except
{
	my( $pos, @x ) = @_;
	splice( @x, $pos, 1 );
	return product(@x);
}



my $debug = 0;
die "Usage: array-of-product [--debug] array\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV>1;
my @x = @ARGV;
my $prod = product(@x);
@x = map { $x[$_]==0 ? prod_except($_, @x) : $prod / $x[$_] } 0..$#x;
say for @x;
