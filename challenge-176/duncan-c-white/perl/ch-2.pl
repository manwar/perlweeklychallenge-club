#!/usr/bin/perl
# 
# Task 2: Reversible Numbers
# 
# Write a script to find out all Reversible Numbers below 100.
# 
# A number is said to be a reversible if sum of the number and its reverse
# had only odd digits.
# 
# For example,
# 
# 36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
# 17 is not reversible as 17 + 71 = 88, none of the digits are odd.
# 
# Output
# 
# 10, 12, 14, 16, 18, 21, 23, 25, 27,
# 30, 32, 34, 36, 41, 43, 45, 50, 52,
# 54, 61, 63, 70, 72, 81, 90
# 
# MY NOTES: Unusually, this seems even easier than task 1.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

my $debug=0;
die "Usage: reversible-numbers-below-N [--debug] [N default 100]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

#
# my $isrev = is_reversible($x);
#	Return true iff $x is reversible, in the above sense,
#	otherwise return false.
#
fun is_reversible( $x )
{
	my $r = reverse($x);
	my $sum = $x + $r;
	my @odd = grep { /[02468]/ } split(//, $sum);
	return @odd==0 ? 1 : 0;
}



my $limit = (shift // 100) - 1;

my @rev;
foreach my $x (1..$limit)
{
	push @rev, $x if is_reversible($x);
}
say join( ', ', @rev );
