#!/usr/bin/perl

use Test::More;
use Test::Deep;

is_deeply( split_list([ 1, 4, 3, 2, 5, 2 ], 3), [ 1, 2, 2, 4, 3, 5 ]);

done_testing;

sub split_list {
    my ($L, $K) = @_;

    my $before = [];
    my $after  = [];
    foreach my $i (@$L) {
        if ($i < $K) {
            push @$before, $i;
        }
        else {
            push @$after, $i;
        }
    }

    return [ @$before, @$after ];
}
