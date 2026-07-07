#!/usr/bin/env raku

use Test;

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

for @examples -> $ex {
    is valid-square($ex<in>), $ex<out>;
}

done-testing;

sub valid-square($matrix) {
    my $n = $matrix.elems;

    for @$matrix -> $row {
        my %seen = $row.Set;
        return 0 unless %seen.elems == $n && %seen.keys.all ~~ 1..$n;
    }

    for 0 .. $n - 1 -> $col_idx {
        my %seen;
        for 0 .. $n - 1 -> $row_idx {
            %seen{$matrix[$row_idx][$col_idx]} = 1;
        }

        return 0 unless %seen.elems == $n && %seen.keys.all ~~ 1..$n;
    }

    return 1;
}
