#!/usr/bin/env perl
# Perl weekly challenge 391
# Task 1:  Array Median
#
# See https://wlmb.github.io/2026/09/14/PWC391/#task-1-array-median
use v5.40;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 A0 B0 A1 B1...
    to merge arrays An with Bn and print the median.
    An Bn are provided as a string of space separated numbers.
    FIN
for my($string1, $string2)(@ARGV){
    my @merged = sort {$a<=>$b} map {split " ", $_} $string1, $string2;
    my $middle=floor((@merged-1)/2);
    say "$string1; $string2 -> ",
	($merged[$middle] + $merged[@merged - 1 - $middle])/2;
}
