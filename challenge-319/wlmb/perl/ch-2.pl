#!/usr/bin/env perl
# Perl weekly challenge 319
# Task 2:  Minimum Common
#
# See https://wlmb.github.io/2025/04/28/PWC319/#task-2-minimum-common
use v5.36;
use List::Util qw/min/;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 X1 Y1 X2 Y2...
    where Xn and Yn are strings with space separated numbers,
    to find the minimum common element of the corresponding sets.
    FIN
for my ($x,$y)(@ARGV){
    my ($ax, $ay)=map {[split " ", $_]} $x, $y;
    my %found;
    $found{$_}++ for @$ax;
    my $result = (min grep{$found{$_}} @$ay)//-1;
    say "$x; $y -> $result";
}
