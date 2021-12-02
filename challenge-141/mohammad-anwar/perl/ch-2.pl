#!/usr/bin/perl

=head1

Week 141:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-141

Task #2: Like Numbers

    You are given positive integers, $m and $n.

    Write a script to find total count of integers created using the digits of $m which is also divisible by $n.

=cut

use strict;
use warnings;
use Test::More;
use Test::Deep;
use Algorithm::Combinatorics qw(combinations);

is_deeply(
    like_numbers(1234, 2),
    [2, 4, 12, 14, 24, 34, 124, 134, 234],
    'Example 1'
);

is_deeply(
    like_numbers(768, 4),
    [8, 76, 68.],
    'Example 2'
);

done_testing;

sub like_numbers {
    my ($m, $n) = @_;

    my @numbers = ();
    foreach my $i (1 .. length($m)-1) {
        foreach my $j (combinations([ split //, $m ], $i)) {
            my $k = join('', @$j);
            if ($k % $n == 0) {
                push @numbers, $k;
            }
        }
    }

    return \@numbers;
}
