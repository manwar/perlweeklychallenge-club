#!/usr/bin/env raku

use Test;
plan 4;

is-deeply max-sub-matrix(<1 0 0 0 1 0>,
                         <1 1 0 0 0 1>,
                         <1 0 0 0 0 0>), 
                         ['2 x 3 at rows 1..2 and cols 2..4', 
                          '3 x 2 at rows 0..2 and cols 2..3'], 
                         'Example 1';

is-deeply max-sub-matrix(<0 0 1 1>,
                         <0 0 0 1>,
                         <0 0 1 0>), 
                         ['3 x 2 at rows 0..2 and cols 0..1'], 
                         'Example 2';

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
                         <1 0 0 0 0 0 0 0 1 0 1 0>), 
                         ['4 x 3 at rows 2..5 and cols 1..3', 
                          '6 x 2 at rows 5..10 and cols 9..10'],
                          'Example 3';

is-deeply max-sub-matrix(
    [0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1],
    [0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1],
    [0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0],
    [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
    [1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0],
    [1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
    [1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0],
    [0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
    [1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]), 
                          ['2 x 9 at rows 13..14 and cols 0..8',
                           '2 x 9 at rows 16..17 and cols 4..12'],
                           'E Choroba\'s Matrix';

sub max-sub-matrix(+@matrix)
{
    my %results;

    my @zero-indices = @matrix.map({ .grep(0, :k) })>>.Array;

    for (^@matrix).combinations: 2 -> ($first-row, $last-row) 
    {
        my @cols = ([(&)] @zero-indices[$first-row .. $last-row]).keys
                                                                 .sort
                                                                 .Array;
        next unless @cols > 1;
        my $rows = $last-row - $first-row + 1;

        for consecutives(@cols) -> $cols
        {
            next unless $cols > 1;
            my $k = "$rows x {+$cols} at rows "  ~
                    "$first-row..$last-row and " ~
                    "cols {$cols.head}..{$cols.tail}"; 

            %results{$k} = $rows * $cols;
        }
    }

    %results.maxpairs>>.key.sort.Array;
}

sub consecutives(@cols)
{
    my $i;

    my @consecutives = gather for (|@cols, Inf).rotor(2 => -1)
    {
        $i++;

        if .head !== .tail - 1
        {
            take $i;
            $i = 0;
        }
    }

    @cols.rotor(@consecutives);
}
