#!/usr/bin/env perl
# Perl weekly challenge 148
# Task 2: largest square
#
# See https://wlmb.github.io/2022/01/24/PWC149/#task-2-largest-square
use v5.12;
use warnings;
use List::MoreUtils qw(duplicates);
use bigint;
my @digits=(0..9,'A'..'Z');
die "Usage: ./ch-2.pl N [P] [Q]... " .
    "to obtain largest square in base N P Q...\n"
    unless @ARGV;
foreach my $base(@ARGV){
    my $root=$base**($base/2);
    --$root while duplicates(convert($root*$root, $base));
    say "f($base)=",convert($root*$root, $base);
}
sub convert{
    my ($N, $base)=@_; # convert $N to $base
    my @d=();
    do {push @d, $N%$base} while $N/=$base;
    return reverse map {$digits[$_]} @d;
}
