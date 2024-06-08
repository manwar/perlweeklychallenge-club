#!/usr/bin/env perl
# Perl weekly challenge 268
# Task 1:  Magic Number
#
# See https://wlmb.github.io/2024/05/06/PWC268/#task-1-magic-number
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV==2;
    Usage: $0 X Y
    where X is "[x1 x2...]" and Y=[y1 y2...]
    to find the magic number M which added to the elements
    of X yields the elements of Y
    FIN
my ($x,$y)=map{pdl $_}@ARGV;
my (undef, $values)=($y->qsort-$x->qsort)->rle;
say "@ARGV -> ", $values->dim(0)==1?$values:"None"
