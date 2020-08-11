#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use constant SEXY_PAIRS => 10;
use constant SEXY_DIFF => 6;
use Math::Prime::Util qw(is_prime);

MAIN: {
    my ($i, @pairs) = (1, ());
    while (scalar @pairs <= SEXY_PAIRS) {
        my $primes = sexy_primes($i);
        push @pairs, $primes if ($primes);
        $i++;
    }
    say qq|Total ${\SEXY_PAIRS} sexy prime pairs:|;
    say join q|,|, map { "($_->[0],$_->[1])" } @pairs;
}

sub sexy_primes {
    my ($n) = @_;
    return (is_prime($n) && is_prime($n + SEXY_DIFF))
        ? [$n, $n + SEXY_DIFF] : undef
}

1;

__END__

Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime
numbers that differ from each other by 6. For example, the numbers 5 and 11 are
both sexy primes, because 11 - 5 = 6. The term “sexy prime” is a pun stemming
from the Latin word for six: sex.
See https://en.wikipedia.org/wiki/Sexy_prime

$ perl ch-1.pl
(5,11),(7,13),(11,17),(13,19),(17,23),(23,29),(31,37),(37,43),(41,47),(47,53),(53,59)
