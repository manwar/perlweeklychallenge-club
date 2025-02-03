#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;

while (scalar @ints > 1) {
    @ints = sort { $b <=> $a } @ints;

    my $y = $ints[0];
    my $x = $ints[1];

    if ($x == $y) {
        splice @ints, 0, 2;
    } else {
        splice @ints, 1, 1;
        $ints[0] = $y - $x;
    }
}

say $ints[0] // 0;
