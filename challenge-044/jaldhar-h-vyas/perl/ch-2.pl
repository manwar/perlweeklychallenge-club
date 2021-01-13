#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @result;
my $n = 200;

while ($n != 1) {
    if ($n % 2 == 0) {
        unshift @result, 'double';
        $n /= 2;
    } else {
        unshift @result, 'add one';
        $n--;
    }
}

say join q{, }, @result;

