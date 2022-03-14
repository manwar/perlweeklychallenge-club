#!/usr/bin/perl
use 5.030;
use warnings;
no warnings 'experimental';
use Memoize;

sub fibonacci {
    my ($n) = @_;

    if ($n <= 1) {
        return $n;
    }
    return fibonacci($n - 1) + fibonacci($n - 2);
}

sub pisano {
    my ($n) = @_;
    my $i = 2;

    while (1) {
        my @moduli = map { fibonacci($_) % $n; } 0 .. $i -1;

        if (@moduli[0 .. $i / 2 - 1] ~~ @moduli[$i / 2 .. $#moduli]) {
            return $i / 2;
        }
        $i += 2;
    }
}

memoize('fibonacci');
say pisano(3);
