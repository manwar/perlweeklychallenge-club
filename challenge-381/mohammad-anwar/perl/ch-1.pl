#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use List::Util qw(all);

my @examples = (
    {
        in  => [[1, 2, 3, 4],[2, 3, 4, 1],[3, 4, 1, 2],[4, 1, 2, 3]],
        out => 1
    },
    {
        in  => [[1]],
        out => 1
    },
    {
        in  => [[1,2,5],[5,1,2],[2,5,1]],
        out => 0
    },
    {
        in  => [[1,2,3],[1,2,3],[1,2,3]],
        out => 0
    },
    {
        in  => [[1,2,3],[3,1,2],[3,2,1]],
        out => 0
    },
);

is valid_square($_->{in}), $_->{out} foreach @examples;

done_testing;

sub valid_square {
    my ($matrix) = @_;
    my $n = scalar @$matrix;

    for my $row (@$matrix) {
        my %seen = map { $_ => 1 } @$row;
        return 0 unless scalar keys %seen == $n && all { $_ >= 1 && $_ <= $n } keys %seen;
    }

    for my $col_idx (0 .. $n - 1) {
        my %seen;
        for my $row_idx (0 .. $n - 1) {
            $seen{$matrix->[$row_idx][$col_idx]} = 1;
        }

        return 0 unless scalar keys %seen == $n && all { $_ >= 1 && $_ <= $n } keys %seen;
    }

    return 1;
}
