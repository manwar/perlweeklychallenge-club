#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my $swaps = 0;

while ($ints[0] != 1 && $#ints != scalar @ints) {
    for my $i (1 .. scalar @ints - 1) {
        if ($ints[$i - 1] > $ints[$i]) {
            my $temp = $ints[$i];
            $ints[$i] = $ints[$i - 1];
            $ints[$i - 1] = $temp;
            $swaps++;
        }
    }
}

say $swaps;