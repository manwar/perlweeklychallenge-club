#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);

# Interestigly, both CPAN modules can be used interchangeably.
# use Math::Prime::Util qw(nth_prime next_prime prev_prime);
use ntheory qw(nth_prime next_prime prev_prime);

# See https://en.wikipedia.org/wiki/Strong_prime
# See https://oeis.org/A051634
# See https://oeis.org/A051635
sub prime_type {
    my ($prime) = @_;

    my $pprime = prev_prime($prime);
    my $nprime = next_prime($prime);

    return 'strong'  if ($prime > ($pprime + $nprime) / 2);
    return 'weak'    if ($prime < ($pprime + $nprime) / 2);
}

sub nth_strong_primes {
    my ($nth) = @_;

    my ($pos, @primes) = (2, ());
    while (scalar @primes < $nth) {
        my $prime = nth_prime($pos);
        push @primes, $prime if (prime_type($prime) eq 'strong');
        $pos++;
    }

    return \@primes;
}

sub nth_weak_primes {
    my ($nth) = @_;

    my ($pos, @primes) = (2, ());
    while (scalar @primes < $nth) {
        my $prime = nth_prime($pos);
        push @primes, $prime if (prime_type($prime) eq 'weak');
        $pos++;
    }

    return \@primes;
}

say 'Strong primes: ' , join ', ', @{nth_strong_primes(10)};
say 'Weak primes: ', join ', ', @{nth_weak_primes(10)};

1;

__END__
$ perl ch-1.pl
Strong primes: 11, 17, 29, 37, 41, 59, 67, 71, 79, 97
Weak primes: 3, 7, 13, 19, 23, 31, 43, 47, 61, 73
