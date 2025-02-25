#!/usr/bin/env perl
# Perl weekly challenge 302
# Task 1:  Ones and Zeroes
#
# See https://wlmb.github.io/2024/12/29/PWC302/#task-1-ones-and-zeroes
use v5.36;
use List::Util qw(max sum);
use List::UtilsBy qw(rev_nsort_by);
die <<~"FIN" unless @ARGV > 2;
    Usage: $0 x y S1 S2...
    to find the largest subset of the binary strings S1, S2...
    such that its total number of zeroes and ones doesn't exceed x and y respectively.
    FIN
my ($x,$y,@str)=@ARGV;
for(@str){
    die "$_ is not binary" unless /^[01]+$/;
}
my @descriptions = map {
    my $ones = sum(my @digits = split "");
    my $zeroes = @digits - $ones;
    [$zeroes, $ones]
} rev_nsort_by {length} @str;
my $max = 0;
$max = max($max, subset($x, $y, @descriptions[$_..@descriptions-1])) for 0..@descriptions-1;
say "x=$x, y=$y, str=(@str) -> $max";
sub subset($zeroes, $ones, @rest){
    return 0 unless @rest && ($zeroes || $ones);
    my @rest1 = @rest;
    my ($zeroes1, $ones1) = shift(@rest1)->@*;                 # try first element of @rest
    $zeroes >= $zeroes1 && $ones >= $ones1                     # if enough zeroes and ones available
	? 1 + subset($zeroes -$zeroes1,$ones - $ones1, @rest1) # add element to subset
	: subset($zeroes, $ones, @rest1);                      # otherwise, don't
}
