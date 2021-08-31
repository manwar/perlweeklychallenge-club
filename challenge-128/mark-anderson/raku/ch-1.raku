#!/usr/bin/env raku

use Test;
plan 3;

is-deeply max-sub-matrix(<1 0 0 0 1 0>,
                         <1 1 0 0 0 1>,
                         <1 0 0 0 0 0>), ['2 x 3', '3 x 2'];

is-deeply max-sub-matrix(<0 0 1 1>,
                         <0 0 0 1>,
                         <0 0 1 0>), ['3 x 2',];

is-deeply max-sub-matrix(<1 0 1 0 1 0 1 0 1 0 0 1>,
                         <1 0 1 0 1 0 1 0 1 0 0 1>,
                         <1 0 0 0 1 0 0 0 1 1 0 0>,
                         <1 0 0 0 1 0 0 0 1 1 0 0>,
                         <1 0 0 0 1 0 1 0 1 0 1 1>,
                         <1 0 0 0 1 0 0 0 1 0 0 1>,
                         <1 0 1 0 1 0 1 0 1 0 0 1>,
                         <1 0 1 0 1 0 1 0 1 0 0 0>,
                         <1 0 1 0 1 0 1 0 1 0 0 1>,
                         <1 0 1 0 1 0 1 0 1 0 0 1>,
                         <1 0 1 0 1 0 1 0 1 0 0 0>,
                         <1 0 0 0 0 0 0 0 1 0 1 0>), ['4 x 3', '6 x 2'];

sub max-sub-matrix(+$matrix)
{
    my %h;
    my %results;

    for ^$matrix -> $i
    {
        for $matrix[$i].join ~~ m:g/00+/
        {
            %h{$i}.push: .from .. .pos-1;
        }
    }

    for (^$matrix).combinations: 2 -> ($head, $tail) 
    {
        for [X] %h{$head .. $tail} -> @rows
        {
            my $cols = +([(&)] @rows);
            my $rows = $tail - $head + 1;
            my $area = $rows * $cols;
            %results{"$rows x $cols"} = $area;
        }
    }

    %results.maxpairs>>.key.sort.Array;
}
