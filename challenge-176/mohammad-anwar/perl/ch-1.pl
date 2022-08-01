#!/usr/bin/perl

=head1

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task #1: Permuted Multiples

    Write a script to find the smallest integer x such that x, 2x,
    3x, 4x, 5x and 6x are permuted multiples of each other.

=cut

use Test2::V0;

use v5.36;
use experimental qw(builtin);
use builtin qw(true false is_bool);

is 142857, smallest_permuted_multiples();

done_testing;

#
#
# METHODS

sub has_same_digits($m, $n) {
    my @x = split //, $m;
    my @y = split //, $n;
    return join(q{}, sort @x) == join(q{}, sort @y);
}

sub smallest_permuted_multiples {
    my $i = 10;
    while (true) {
        my $found = true;
        foreach my $j (2..6) {
            if (!has_same_digits($i, $i * $j)) {
                $found = false;
                last;
            }
        }

        return $i if $found;
        $i += 1;
    }
}
