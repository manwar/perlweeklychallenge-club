#!/usr/bin/env perl

# Perl Weekly Challenge 368 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-368/

use Modern::Perl;

@ARGV==2 or die "usage: $0 number mode";
say count_prime_factors(@ARGV);

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

sub count_prime_factors {
    my($n, $mode) = @_;
    my @primes = prime_factors($n);
    return scalar(@primes) if $mode;    # count of all primes including duplicates
    my %primes; $primes{$_}=1 for @primes;
    return scalar(keys %primes);        # count of distinct primes
}
