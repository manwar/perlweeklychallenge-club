#!/usr/bin/env perl

use strict;
use warnings;
use v5.30;

my @A = @ARGV;
@A = (9, 10, 7, 5, 6, 1) unless @A;
my @L;

eval {state$i=0;push @L, $_ if $_ == shift @{[sort {$b <=> $a} @A[$i++..$#A]]}} for @A;

say join ',', @L;
