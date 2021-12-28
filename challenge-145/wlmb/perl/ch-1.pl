#!/usr/bin/env perl
# Perl weekly challenge 145
# Task 1: Dot product
#
# See https://wlmb.github.io/2021/12/27/PWC145/#task-1-dot-product
use v5.12;
use warnings;
use PDL;
use List::Util;
die "Usage: ./ch-1.pl 'x1 x2... xn' 'y1 y2... yn' to find dot product x.y"
     unless @ARGV==2;
my ($x,$y)=map pdl([split " ", $_]), @ARGV;
die "Vectors should have the same positive length"
     unless $x->nelem>0 && $y->nelem>0 && $x->nelem==$y->nelem;
say "x=$x, y=$y, x.y=", $x->inner($y);
