#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @L = sort @ARGV;
my $size = scalar @L;

for (my $n = 0; $n < $size; $n++) {
    if ($L[$n] == $size - $n - 1) {
        say $L[$n];
    }
}