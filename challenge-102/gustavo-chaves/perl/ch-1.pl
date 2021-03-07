#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/
# TASK #1 › Rare Numbers

use 5.030;
use warnings;

my $digits = shift or die "Usage: $0 N\n";

my @squares = (0);
while ($squares[-1] < 2*(10**$digits)) {
    push @squares, @squares * @squares;
}

# This is very inefficient... :-(

for (my $r = $#squares; $r > 1; --$r) {
    my $xx = $squares[$r];
    for (my $l = $r-1; $l >= 1; --$l) {
        my $yy = $squares[$l];
        my $dr = $xx + $yy;
        next unless ($dr % 2) == 0;
        my $dl = $xx - $yy;
        next unless ($dl % 2) == 0;
        my $R = $dr / 2;
        next unless length("$R") == $digits;
        my $L = sprintf "%0${digits}d", $dl / 2;
        say $R if "$R" eq reverse("$L");
    }
}
