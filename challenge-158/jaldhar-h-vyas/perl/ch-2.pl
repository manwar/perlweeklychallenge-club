#!/usr/bin/perl
use 5.030;
use warnings;

sub isPrime {
    my ($n) = @_;

    if ($n < 2) {
        return undef;
    }

    if ($n == 2) {
        return 1;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return undef;
        }
    }

    return 1;
}

my $y = 1;
my @cubans;

while(1) {
    my $p = 3 * $y ** 2 + 3 * $y + 1;
    if ($p > 1000) {
        last;
    }
    if (isPrime($p)) {
        push @cubans, $p;
    }
    $y++;
}

say join q{, }, @cubans;