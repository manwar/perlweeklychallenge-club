#!/usr/bin/perl

=head1

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #2: Magical Triplets

    You are given a list of positive numbers, @n, having at least
    3 numbers.

    Write a script to find the triplets (a, b, c) from the given list
    that satisfies the following rules.

    1. a + b > c
    2. b + c > a
    3. a + c > b
    4. a + b + c is maximum.

    In case, you end up with more than one triplets having the maximum
    then pick the triplet where a >= b >= c.

=cut

use v5.36;
use Test2::V0;
use Algorithm::Combinatorics qw(variations);

is magical_triplets(1, 2, 3, 2), [3, 2, 2], 'Example 1';
is magical_triplets(1, 3, 2),    [],        'Example 2';
is magical_triplets(1, 1, 2, 3), [],        'Example 3';
is magical_triplets(2, 4, 3),    [4, 3, 2], 'Example 4';

done_testing;

#
#
# METHOD

sub magical_triplets(@list) {
    my $triplets = variations([ sort { $b <=> $a } @list ], 3);
    my %entries  = ();
    foreach my $triplet ($triplets->next) {
        my ($x, $y, $z) = @$triplet;
        if (($x + $y > $z) &&
            ($y + $z > $x) &&
            ($x + $z > $y)) {
            $entries{join(":", $x, $y, $z)} = $x + $y + $z;
        }
    }

    return [] unless (keys %entries);

    my $magical = [
        sort { $entries{$b} <=> $entries{$b} } keys %entries
    ];

    return [ split /\:/, $magical->[0] ];
}
