#!/usr/bin/perl
use 5.030;
use warnings;

my ($i, @n) = @ARGV;

say join q{, }, grep { $_ > $i } @n;
