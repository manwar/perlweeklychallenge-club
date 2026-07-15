#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub hamiltonian_cycle($n) {
    my @numbers = 2 .. $n;
    return [_hc([1], \@numbers)]
}

sub is_perfect_sq($n) { sqrt $n == int sqrt $n }

sub _hc($list, $remain) {
    if (! @$remain) {
        return is_perfect_sq($list->[0] + $list->[-1]) ? $list : [];
    }

    my @candidates = grep is_perfect_sq($list->[-1] + $_), @$remain;
    return grep @$_,
           map { my $c = $_;
                 _hc([@$list, $c], [grep $_ != $c, @$remain])
               } @candidates
}


use Test2::V0;
plan(3);

is hamiltonian_cycle(32), bag { item([1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3,
                                      13, 12, 24, 25, 11, 5, 31, 18, 7, 29,
                                      20, 16, 9, 27, 22, 14, 2, 23, 26, 10,
                                      15]);
                                etc() },
    'Example 1';

is hamiltonian_cycle(15), [], 'Example 2';

is hamiltonian_cycle(34), bag { item([1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34,
                                      15, 10, 26, 23, 2, 14, 22, 27, 9, 16,
                                      33, 31, 18, 7, 29, 20, 5, 11, 25, 24,
                                      12, 13, 3]);
                                etc() },
    'Example 3';
