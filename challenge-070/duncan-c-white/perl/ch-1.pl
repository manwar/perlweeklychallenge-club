#!/usr/bin/perl
#
# Task 1: "Character Swapping
# 
# You are given a string $S of size $N.
# 
# You are also given swap count $C and offset $O such that $C >= 1, $O >=
# 1, $C <= $O and $C + $O <= $N.
# 
# Write a script to perform character swapping like below:
# 
# for i = 1 to $C
#   S[ i % N ] <=> S[ (i + O) % N ]
# 
# Example 1
# 
# Input:
#     $S = 'perlandraku'
#     $C = 3
#     $O = 4
# 
# 01234567890
# perlandraku
# 
# Character Swapping:
#     swap 1: pos 1 and 5: e <=> n = pnrlaedraku
#     swap 2: pos 2 and 6: r <=> d = pndlaerraku
#     swap 3: pos 3 and 7: l <=> r = pndraerlaku
# 
# Output:
#     pndraerlaku
# "
# 
# My notes: ok.  none of $i % N (for i=1..$C) needs the % N
# given that $C + $O <= $N and min $O is 1.  So that becomes:
# 
# for i = 1 to $C
#   S[ i ] <=> S[ (i + O) % N ]
# 
# and the only one of the (i + O) % N expressions that may need
# the % N part is i=C, when C+O == N.  Of course i + O increments
# so pre-calculate it, increment it each time through the loop,
# and set it back to 0 hit it hits N.
#

use strict;
use warnings;
use feature 'say';
#use Function::Parameters;
#use Data::Dumper;

die "Usage: char-swaps S C O\n" unless @ARGV==3;
my( $s, $c, $o ) = @ARGV;
my $n = length($s);

die "char-swaps: C must be >= 1 ($c given)\n" unless $c>=1;
die "char-swaps: O must be >= 1 ($o given)\n" unless $o>=1;
die "char-swaps: C must be <= O (C:$c, O:$o given)\n" unless $c<=$o;
die "char-swaps: C + O must be <= N (C:$c, O:$o, N:$n given)\n" unless
	$c + $o <= $n;

my $dst = $o+1;
foreach my $i (1..$c)
{
	( substr($s,$i,1), substr($s,$dst,1) ) =
		( substr($s,$dst,1), substr($s,$i,1) );
	$dst++;
	$dst = 0 if $dst == $n;
}

say "result: $s";
