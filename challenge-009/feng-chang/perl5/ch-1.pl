#!/bin/env perl

use Modern::Perl;
use List::Uniq ':all';

my $n = 101;
my $n2;

while (1) {
    $n2 = $n * $n;
    last if @{ uniq sort split(//, $n2) } >= 5;

    ++$n;
}

say "$n2 = $n * $n";
