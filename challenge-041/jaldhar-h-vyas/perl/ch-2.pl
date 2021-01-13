#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use Memoize;

sub leonardo {
    my ($n) = @_;

    if ($n < 2) {
        return 1;
    }

    return leonardo($n - 2) + leonardo($n - 1) + 1;
}

memoize('leonardo');

for my $n (0 .. 19) {
    say leonardo($n);
}