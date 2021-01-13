#!/usr/bin/env perl6

use Test;

my $unit-tests = :{
    90 => {
            in  => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ],
            out => [ [ 7, 4, 1 ], [ 8, 5, 2 ], [ 9, 6, 3 ] ],
          },
   180 => {
            in  => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ],
            out => [ [ 9, 8, 7 ], [ 6, 5, 4 ], [ 3, 2, 1 ] ],
          },
   270 => {
            in  => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ],
            out => [ [ 3, 6, 9 ], [ 2, 5, 8 ], [ 1, 4, 7 ] ],
          },
};

for $unit-tests.keys.sort -> $degree {
    my $in  = $unit-tests{$degree}<in>;
    my $out = $unit-tests{$degree}<out>;
    is-deeply(rotate-matrix($in, $degree), $out, "rotation by $degree.");
}

done-testing;

sub rotate-matrix(Array $matrix is copy, Int $rotate-by = 90) {
    die "ERROR: Invalid rotation degree $rotate-by."
        unless $rotate-by ~~ any (90, 180, 270);

    for 1 .. $rotate-by/90 {
        my $rows = $matrix.elems;
        my $cols = $matrix.[0].elems;

        my $_matrix;
        for 0 .. $rows-1 -> $i {
            my $k = 2;
            for 0 .. $cols-1 -> $j {
                $_matrix.[$i][$j] = $matrix.[$k][$i];
                $k--;
            }
        }
        $matrix = $_matrix;
    }

    return $matrix;
}
