#!/usr/bin/perl
# test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;
use bignum;

our @NUMS = (0..9,'A' .. 'Z');

for my $i (1..36) {
    say $i . ': ' .
        self_descriptive_x($i) . ' - ' .
        self_descriptive_10($i);
}

sub self_descriptive_x {
    my $b = shift;

    return 'no solution' if
        ( $b == 1 || $b == 2 ||
          $b == 3 || $b == 6);

    return 1210 if ($b == 4);
    return 21200 if ($b == 5);

    return
        $NUMS[($b - 4)] . '2' . 1 . 0 x ($b - 7) . '1000';
}

sub self_descriptive_10 {
    my $b = shift;

    return 'no solution' if
        ( $b == 1 || $b == 2 ||
          $b == 3 || $b == 6);

    return 100 if ($b == 4);
    return 1425 if ($b == 5);

    return
        ($b - 4) * $b ** ($b - 1) +
        2 * $b ** ($b - 2) +
        $b ** ($b - 3) +
        $b ** 3;
}
