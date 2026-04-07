#!/usr/bin/env perl

# Perl Weekly Challenge 164 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-164/

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

sub next_prime {
    my($n) = @_;
    return 2 if $n <= 1;
    my $p = $n;
    1 while !is_prime(++$p);
    return $p;
}

sub primes {
    my($n) = @_;
    my $p = 2;
    my @primes;
    while ($p <= $n) {
        push @primes, $p;
        $p = next_prime($p);
    }
    return @primes;
}

sub palindrome_primes {
    my($n) = @_;
    my @primes=primes($n);
    return grep {$_ eq reverse $_} @primes;
}

say "(", join(", ", palindrome_primes(shift)), ")";
