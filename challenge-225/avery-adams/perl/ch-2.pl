#!/usr/bin/perl

use strict;
use v5.24;

my @ints = @ARGV;
my (@left, @right, @diff);
push @left, 0;
unshift @right, 0;
if ($#ints) {
    foreach (1..$#ints) {
        push @left, $left[$_ - 1] + $ints[$_ - 1];
        unshift @right, $right[-$_] + $ints[-$_];
    }
}
foreach (0..$#ints) {
    $diff[$_] = abs($left[$_] - $right[$_]);
}
say $_ for @diff;
