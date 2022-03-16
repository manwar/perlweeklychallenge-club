#!/usr/bin/perl

=head1

Week 156:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-156

Task #1: Pernicious Numbers

    Write a script to permute first 10 Pernicious Numbers.

=cut

use strict;
use warnings;
use Test::More;

is_deeply(pernicious_numbers(10), [3, 5, 6, 7, 9, 10, 11, 12, 13, 14], 'Example');

done_testing;

#
#
# METHOD

sub pernicious_numbers {
    my ($n) = @_;

    my $i  = 1;
    my $pn = [];
    while (@$pn < $n) {
        my $bin = sprintf("%b", $i);
        my $sum = 0;
        $sum += $_ for (split //, $bin);
        push @$pn, $i if is_prime($sum);
        $i++;
    }

    return $pn;
}

sub is_prime {
    my ($n) = @_;

    return 0 if ($n == 1);

    foreach my $i (2 .. sqrt $n) {
        return 0 unless $n % $i
    }

    return 1;
}
