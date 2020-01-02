#!/usr/bin/perl
#
# Task 2: "Write a script to display the first 20 Leonardo Numbers. Read
# https://en.wikipedia.org/wiki/Leonardo_number for more information.
# 
# For example:
# L(0) = 1
# L(1) = 1
# L(2) = L(0) + L(1) + 1 = 3
# L(3) = L(1) + L(2) + 1 = 5
# 
# and so on.
# "
# 
# My notes: sounds very nearly as simple as Fibonacci numbers.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
#use Data::Dumper;

die "Usage: ch-2.pl [N//20]\n" if @ARGV>1;
my $n = shift // 20;

my %l;
$l{0} = 1;
$l{1} = 1;
say "leonardo(0) = $l{0}";
say "leonardo(1) = $l{1}";

foreach my $i (2..$n-1)
{
	$l{$i} = $l{$i-2} + $l{$i-1} + 1;
	say "leonardo($i) = $l{$i}";
}

