#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

=head1

Week 133:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-133

Task #1: Integer Square Root

    You are given a positive integer $N.

    Write a script to calculate the integer square root of the given number.

=cut

is( isqrt(10),   3 );
is( isqrt(27),   5 );
is( isqrt(85),   9 );
is( isqrt(101), 10 );

done_testing;

#
# Implemented the algorithm proposed in the wikipedia
# as recommended in the task.
#
# https://en.wikipedia.org/wiki/Integer_square_root

sub isqrt {
    my ($n) = @_;

    die "ERROR: Missing number.\n"      unless defined $n;
    die "ERROR: Invalid number [$n].\n" unless ($n >= 0);

    return $n if ($n < 2);

    my $small_cand = isqrt($n >> 2) << 1;
    my $large_cand = $small_cand + 1;

    return ($large_cand * $large_cand > $n)
           ?
           ($small_cand)
           :
           ($large_cand);
}
