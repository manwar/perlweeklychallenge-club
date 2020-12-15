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

my @stepping_stones;
push @stepping_stones, 0;
foreach(1..$#stones){
    unshift @stepping_stones, $_ if $stepping_stones[0] >= $_-$stones[$_];
}
say $stepping_stones[0]==$#stones # Notice I numbered stones from right to left
    ?"1 Success\nPath: " . join "->", @stepping_stones # Notice I n
    :"0 Failure";
