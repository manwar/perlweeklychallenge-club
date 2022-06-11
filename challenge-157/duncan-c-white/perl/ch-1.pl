#!/usr/bin/perl
# 
# TASK #1 - Pythagorean Means
# 
# You are given a set of integers.
# 
# Write a script to compute all three Pythagorean Means i.e Arithmetic Mean,
# Geometric Mean and Harmonic Mean of the given set of integers. Please
# refer to wikipedia page for more informations.
# 
# Example 1:
# 
# 	Input: @n = (1,3,5,6,9)
# 	Output: AM = 4.8, GM = 3.9, HM = 2.8
# 
# Example 2:
# 
# 	Input: @n = (2,4,6,8,10)
# 	Output: AM = 6.0, GM = 5.2, HM = 4.4
# 
# Example 3:
# 
# 	Input: @n = (1,2,3,4,5)
# 	Output: AM = 3.0, GM = 2.6, HM = 2.2
# 
# MY NOTES: ok.  Pretty easy, although the geometric mean involves
# calculating the product of the numbers, which may get pretty huge.
# Tried bigrat, but it broke the nth-root calculation using **.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(sum0 product);
#use Data::Dumper;

my $debug=0;
die "Usage: pythogoran-means [--debug] number+\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

# allow any mixture of commas and spaces (separate arguments)
my $str = join(',',@ARGV);
$str =~ s/\s/,/g;

my @x = split(/,/, $str);
my $n = @x;

my $total = sum0(@x);
my $prod = abs(product(@x));
my $recipsum = sum0( map { 1/$_ } @x );

say "n=$n, total=$total, prod=$prod; recipsum=$recipsum";

my $am = $total/$n;		# sum(@x)/$n
my $gm = $prod ** (1/$n); 	# nth_root( $n, abs(product(@x)) )
my $hm = $n /  $recipsum;	# n / sum( reciprocals(@x) )

printf "AM = %.1f, GM = %.1f, HM = %.1f\n", $am, $gm, $hm;
