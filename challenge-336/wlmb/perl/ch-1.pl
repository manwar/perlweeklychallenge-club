#!/usr/bin/env perl
# Perl weekly challenge 336
# Task 1:  Equal Group
#
# See https://wlmb.github.io/2025/08/25/PWC336/#task-1-equal-group
use v5.36;
use Math::Prime::Util qw(gcd);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to find if the space separated numbers Nj within the string Ni
    may be grouped into equal sized groups of two or more elements.
    FIN
for(@ARGV){
    my %count;
    $count{$_}++ for split " ";
    say "$_ -> ", gcd(values %count) > 1?"True":"False";
}
