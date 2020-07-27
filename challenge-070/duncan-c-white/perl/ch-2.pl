#!/usr/bin/perl
#
# Task 2: "Gray Code Sequence
# 
# You are given an integer 2 <= $N <= 5.
# 
# Write a script to generate $N-bit gray code sequence.
# 
# 2-bit Gray Code Sequence: [0, 1, 3, 2]
# 
# To generate the 3-bit Gray code sequence from the 2-bit Gray code sequence,
# follow the step below:
# 
# 2-bit Gray Code sequence:                  [0, 1, 3, 2]
# 
# Binary form of the sequence        a) S1 = [00, 01, 11, 10]
# 
# Reverse of S1                      b) S2 = [10, 11, 01, 00]
# 
# Prefix all entries of S1 with '0'  c) S1 = [000, 001, 011, 010]
# 
# Prefix all entries of S2 with '1'  d) S2 = [110, 111, 101, 100]
# 
# Concatenate S1 and S2 gives 3-bit Gray Code sequence
# 				   # e) [000, 001, 011, 010, 110, 111, 101, 100]
# 
# Now convert them back to decimal:
# 
# 3-bit Gray Code sequence              [0, 1, 3, 2, 6, 7, 5, 4]
# 
# Example
# 
# Input: N = 4
# Output: [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]
# "
# 
# My notes: ok.  However, there's no point in taking the original N-1-bit gray
# code sequence, converting it to binary, prepending zeroes and converting it
# back to decimal - because leading zeroes don't change the decimal numbers.
# So the first half of the N-bit gray code sequence is simply the N-1-bit gray
# code sequence unmodified
#

use strict;
use warnings;
use feature 'say';
#use Function::Parameters;
use Data::Dumper;

die "Usage: gray-code N\n" unless @ARGV==1;
my $n = shift;

die "gray-code: 1 <= N <= 5 ($n given)\n" unless $n>=1 && $n<=5;

my @seq = (0,1);	# gray(1)
foreach my $i (2..$n)
{
	# the core of the method:
	#	- reverse:        @x = reverse @seq
	#	- cvt to binary (i-1 digits long, leading zeroes):
	#			  @x = map { sprintf( "%0*b", i-1, $_ ) } @x
	#	- prepend 1:      @x = map { "1$_" } @x
	#	- cvt to decimal: @x = map { eval "0b$_" }  @x )
	my @mutate = map { eval sprintf( "0b1%0*b", $i-1, $_ ) } reverse @seq;
	#die Dumper \@mutate;
	push @seq, @mutate;
	#warn Dumper \@seq;
}

say "gray($n) = ", join(',',@seq);
