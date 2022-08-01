#!/usr/bin/perl

=head1

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task 2: Reversible Numbers

    Write a script to find out all Reversible Numbers below 100.

=cut

use Test2::V0;
use v5.36;
use experimental qw(builtin);
use builtin qw(true false is_bool);

is [
    10, 12, 14, 16, 18, 21, 23, 25, 27,
    30, 32, 34, 36, 41, 43, 45, 50, 52,
    54, 61, 63, 70, 72, 81, 90
], all_reversible_numbers_below(100);

done_testing;

#
#
# METHODS

sub has_all_odd_digits($n) {
    foreach (split //, $n) {
        return false if $_ % 2 == 0;
    }

    return true;
}

sub all_reversible_numbers_below($n) {
    my $rn = [];
    for (1..100) {
        push @$rn, $_ if has_all_odd_digits $_ + reverse;
    }
    return $rn;
}
