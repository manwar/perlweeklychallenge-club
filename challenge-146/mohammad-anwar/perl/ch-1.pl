#!/usr/bin/perl

=head1

Week 146:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-146

Task #1: 10001st Prime Number

    Write a script to generate the 10001st prime number.

=cut

use strict;
use warnings;
use Test::More;

is(find_prime(10_001), 104743, 'Example');

done_testing;

#
#
# METHODS

sub find_prime {
    my ($count) = @_;

    my $c = 0;
    my $n = 2;
    while ($c <= $count) {
        if (is_prime($n)) {
            return $n if (++$c == $count);
        }
        $n++;
    }
}

sub is_prime {
    my ($n) = @_;

    foreach my $i (2 .. sqrt $n) {
        return 0 unless $n % $i
    }

    return 1;
}
