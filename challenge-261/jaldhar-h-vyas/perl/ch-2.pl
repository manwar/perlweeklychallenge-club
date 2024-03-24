#!/usr/bin/perl
use 5.030;
use warnings;

my ($start, @ints) = @ARGV;

for my $i (0 .. scalar @ints - 1) {
    if ($start == $ints[$i]) {
        $start *= 2;
    }
}

say $start;
