#!/usr/bin/perl

=head1

Week 167:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-167

Task #1: Circular Prime

    Write a script to find out first 10 circular primes having at
    least 3 digits (base 10).

=cut

use v5.36;
use Test::More;
use experimental qw(builtin);
use builtin   qw(true false);

is_deeply(
    circular_primes(10),
    [ 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933 ],
    'Example'
);

done_testing;

#
#
# METHODS

sub circular_primes($count) {
    my $cp = [];
    my $i  = 111;
    while (@$cp < $count) {
        push @$cp, $i if is_circular_prime($i, $cp);
        $i++;
    }

    return $cp;
}

sub is_circular_prime($n, $cp) {
    return false if $n =~ /[024568]$/;
    return false unless is_prime($n);

    foreach my $i (possible_circulars($n)) {
        return false if grep /$i/, @$cp;
        return false unless is_prime($i);
    }

    return true;
}

sub possible_circulars($n) {
    my @pc = ();
    my $l  = length($n);
    for (1 .. $l-1) {
        $n = substr($n, 1) . substr($n, 0, 1);
        push @pc, $n;
    }

    return @pc;
}

sub is_prime($n) {
    return false if ($n == 1);
    do { return false unless $n % $_ } for (2 .. sqrt $n);
    return true;
}
