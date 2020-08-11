#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use Carp;
use ntheory qw(primes);

MAIN: {
    my $number =  $ARGV[0] || croak 'ERROR: missing number';
    say sprintf q|Number: %s have prime factors: %s|,
        $number, join q|,|, prime_factors($number);
}

sub prime_factors($number) {
    my $primes = primes(2, $number);
    my @factors;
    foreach my $prime (@{$primes}) {
        while ($number % $prime == 0) {
            $number = $number / $prime;
            push @factors, $prime;
            next if $number == 1;
        }
    }
    return @factors;
}

1;

__END__
$ perl ch-2.pl 228
Number: 228 have prime factors: 2,2,3,19
