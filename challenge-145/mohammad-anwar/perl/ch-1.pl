#!/usr/bin/perl

=head1

Week 145:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-145

Task #1: Dot Product

    You are given 2 arrays of same size, @a and @b.

    Write a script to implement Dot Product.

=cut

use strict;
use warnings;
use Test::More;

eval { dot_product([1,2,3], [5,6]); };
like($@, qr/ERROR/, 'Validate');
is(dot_product([1,2,3], [4,5,6]), 32, 'Example');

done_testing;

sub dot_product {
    my ($a, $b) = @_;

    die "ERROR: Arrays are not same size.\n" unless (@$a == @$b);

    my $dot_product = 0;
    foreach my $i (0 .. $#$a) {
        $dot_product += $a->[$i] * $b->[$i];
    }

    return $dot_product;
}
