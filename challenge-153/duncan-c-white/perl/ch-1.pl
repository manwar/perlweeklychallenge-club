#!/usr/bin/perl
# 
# TASK #1 - Left Factorials
# 
# Write a script to compute Left Factorials of 1 to 10. Please refer OEIS
# A003422 for more information.
# 
# (My summary: left factorial N = sum k! for k in (0..N-1), remembering that
#  0! = 1! = 1.  So lf(N+1) = lf(N) + N!)
# 
# Expected Output:
# 
# 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114
# 
# MY NOTES: easy, 1 pass, calc N! on the fly (by multiplying (N-1)! by N)
#           and add (N-1)! to lf(N-1) to give lf(N).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(min);
#use Data::Dumper;

my $debug=0;
die "Usage: left-factorials [--debug] [firstN - default 10]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 10;

my $fact = 1;
my $lf = 1;
my @lf;
foreach my $i (1..$n)
{
	push @lf, $lf;
	$fact *= $i;
	$lf += $fact;
}

say join( ', ', @lf );
