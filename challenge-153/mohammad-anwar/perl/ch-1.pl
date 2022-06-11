#!/usr/bin/perl

=head1

Week 153:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-153

Task #1: Left Factorials

    Write a script to compute Left Factorials of 1 to 10.

=cut

use strict;
use warnings;
use Test::More;

is_deeply(left_factorials(0, 9), [1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114], 'Example');

done_testing;

#
#
# METHOD

sub left_factorials {
    my ($i, $j) = @_;

    my $lf = [];
    foreach my $n ($i .. $j) {
        my $s = 0;
        foreach my $n (0 .. $n) {
            my $f = 1;
            $f = $f * $_ for 1..$n;
            $s = $s + $f;
        }

        push @$lf, $s;
    }

    return $lf;
}
