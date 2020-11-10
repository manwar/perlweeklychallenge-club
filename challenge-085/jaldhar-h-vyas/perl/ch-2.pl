#!/usr/bin/perl
use 5.020;
use warnings;

sub isPower {
    my ($num) = @_;
    my @results;

    if ($num > 1) {
        for my $m (2 .. sqrt($num)) {
            my $n = 2;
            my $p = $m ** $n;

            while ($p <= $num && $p > 0) {
                if ($p == $num) {
                    push @results, join q{^}, ($m, $n);
                }
                $n++;
                $p = $m ** $n;
            }
        }
    }

    return @results;
}

say scalar isPower(shift) ? 1 : 0;