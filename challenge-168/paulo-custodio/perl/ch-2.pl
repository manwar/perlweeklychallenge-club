#!/usr/bin/env perl

# Perl Weekly Challenge 168 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-168/

use Modern::Perl;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}

sub prime_factors {
    my($n) = @_;
    my @factors;
    my $p = 0;
    while ($n > 1) {
        do { $p++; } while (!is_prime($p));
        while ($n % $p == 0) {
            push @factors, $p;
            $n /= $p;
        }
    }
    return @factors;
}

sub home_prime {
    my($n) = @_;
    die unless $n > 1;
    while (!is_prime($n)) {
        my @factors = prime_factors($n);
        $n = 0+join '', @factors;
    }
    return $n;
}


@ARGV==1 or die "usage: ch-1.pl n\n";
say home_prime(shift);
