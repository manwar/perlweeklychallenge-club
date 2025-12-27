#!/usr/bin/perl
use 5.038;
use warnings;
use Memoize;

sub factorial($n) {
    return ($n == 0) ? 1 : $n * factorial($n - 1);
}

memoize('factorial');

say join q{, }, map { state $sum = 0; $sum += factorial($_) } 0 .. 9;
