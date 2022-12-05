#!/bin/perl
use 5.030;
use warnings;

my ($n) = @ARGV;

say join q{, }, map { sprintf('%0*b', $n, $_); } oct('0b' . ('0' x $n)) .. oct('0b' . ('1' x $n));
