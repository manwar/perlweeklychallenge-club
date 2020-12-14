#!/usr/bin/env perl
# Perl weekly challenge 091
# Task 2: Jump Game
# Test if you can reach last element of an array by succesive jumps of bounded lengths.
# See https:/wlmb.github.io/2020/12/14/PWC91/#task-2-jump-game

use strict;
use warnings;
use v5.10;
use List::Util qw(all any);
use Scalar::Util::Numeric qw(isint);

die "Usage: ./ch-2.pl s0 s1 s2...\n\t with sn maximum number of steps from stone n"
    unless @ARGV;
die "Only non-negative numbers allowed" unless all {isint $_ == 1} @ARGV;
my @stones=reverse @ARGV;

my %is_stepping_stone;
$is_stepping_stone{0}++; #initialize
map {
    my $s=$_;
    $is_stepping_stone{$s}++
	if any {$_ >=$s-$stones[$s]} keys %is_stepping_stone
} (1..$#stones);
say $is_stepping_stone{$#stones}//0;
