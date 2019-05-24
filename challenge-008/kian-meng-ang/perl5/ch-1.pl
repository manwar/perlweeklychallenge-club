#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

# See https://en.wikipedia.org/wiki/Perfect_number
# See https://en.wikipedia.org/wiki/List_of_perfect_numbers
# See https://en.wikipedia.org/wiki/Euclid%E2%80%93Euler_theorem

use 5.010;
use strict;
use warnings;
use utf8;

use Const::Fast;
use Math::Prime::Util qw(prime_iterator is_prime);

const my $TOTAL_PERFECT_NUMBERS => 5;

my $iter = prime_iterator;
my @perfect_numbers = ();

while (scalar @perfect_numbers < $TOTAL_PERFECT_NUMBERS) {
    my $prime_number = $iter->();

    my $mersenne_prime = 2 ** $prime_number - 1;
    next if (!is_prime($mersenne_prime));

    push @perfect_numbers, (2 ** ($prime_number - 1)) * $mersenne_prime;
}

say join q|, |, @perfect_numbers;

1;

__END__
$ perl ch1.pl
6, 28, 496, 8128, 33550336
