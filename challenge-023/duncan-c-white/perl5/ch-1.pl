#!/usr/bin/perl
#
# Challenge 1: "Create a script that prints nth order forward difference
# series. You should be a able to pass the list of numbers and order number
# as command line parameters. Let me show you with an example:
# 
# Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like
# to create 1st order forward difference series (Y). So using the formula
# Y(i) = X(i+1) - X(i), we get the following numbers: (9-5), (2-9), (8-2),
# (1-8), (6-1), ie 4, -7, 6, -7, 5.
# If you noticed, it has one less number than the original series.
# Similarly you can generate the 2nd order forward difference series like:
# (-7-4), (6+7), (-7-6), (5+7) => -11, 13, -13, 12.
# 
# My notes: Clearly defined, very easy - let's have a go..
#
# Example runs:
#
# ./ch-1.pl 1 5 9 2 8 1 6
# 4,-7,6,-7,5
#
# ./ch-1.pl 2 5 9 2 8 1 6
# -11,13,-13,12
#
# ./ch-1.pl 3 5 9 2 8 1 6
# 24,-26,25
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

die "Usage: ch-1.pl N SEQ\n" if @ARGV<2;
my $n = shift;
die "ch-1.pl: N ($n) must be >0\n" if $n<=0;
my @seq = @ARGV;
my $nseq = @seq;
die "ch-1.pl: sequence (@seq) must be at least $n long\n" if $nseq < $n;

foreach (1..$n)
{
	@seq = find_diffs( @seq );
}
say join(',',@seq);

#
# my @diff = find_diffs( @seq );
#	Find the 1st order differences between every element in @seq,
#	i.e. return a 1 element shorter list seq[1]-seq[0], seq[2]-seq[1]...
#
fun find_diffs( @seq )
{
	die "find_diffs: empty sequence given\n" if @seq==0;

	# nb: for every position EXCEPT THE LAST
	my @result = map { $seq[$_+1]-$seq[$_]; } 0..$#seq-1;

	return @result;
}
