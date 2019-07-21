#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub ackermann {
    my ($m, $n) = @_;

    if ($m < 0 || $n < 0) {
        return undef;
    }

    if ($m == 0) {
        return $n + 1;
    }

    if ($n == 0) {
        return ackermann($m - 1, 1);
    }

    return ackermann($m - 1, ackermann($m, $n - 1));
}

say ackermann(1, 2);
