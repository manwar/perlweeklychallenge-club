#!/usr/bin/env perl
# Perl weekly challenge 267
# Task 1:  Product Sign
#
# See https://wlmb.github.io/2024/04/29/PWC267/#task-1-product-sign
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 "x0 ẍ1..." ¨"y0 y1..." ...
    to find the sign of the products x0 x1..., y0 y1..., etc.
    FIN
for(@ARGV){
    my $x=pdl($_);
    say "$x -> ", $x->prodover<=>0;
}
