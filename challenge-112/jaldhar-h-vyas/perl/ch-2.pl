#!/usr/bin/perl
use 5.020;
use warnings;

sub fibonacci {
    my ($n) = @_;

    if ($n <= 1) {
        return $n;
    }
    return fibonacci($n - 1) + fibonacci($n - 2);
}

my $stairs = shift // die "Must specify number of stairs to climb.\n";

say fibonacci($stairs + 1);
