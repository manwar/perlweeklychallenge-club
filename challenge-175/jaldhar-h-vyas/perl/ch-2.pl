#!/usr/bin/perl
use 5.030;
use warnings;

sub gcd {
    my ($a, $b) = @_;

    return 0 == $b ? $a : gcd($b, $a % $b);
}

sub isPerfectTotient {
    my ($n) = @_;
    my $total = 0;
    my $current = $n;

    while ($current != 0) {
        my $totients = totients($current);
        $total += $totients;
        $current = $totients;
    }

    return $total == $n;
}

sub totients {
    my ($n) = @_;
    my $tots = 0;
    for my $i (1 .. $n - 1) {
        if (gcd($i, $n) == 1) {
            $tots++;
        }
    }

    return $tots;
}

my @perfectTotients;
my $n = 1;

while (scalar @perfectTotients < 20) {
    if (isPerfectTotient($n)) {
        push @perfectTotients, $n;
    }
    $n++;
}

say join q{, }, @perfectTotients;
