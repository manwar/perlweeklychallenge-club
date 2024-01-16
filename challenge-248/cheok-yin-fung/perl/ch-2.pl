# The Weekly Challenge 248
# Task 2 Submatrix Sum
use v5.30.0;
use warnings;

sub ss {
    my @mat = $_[0]->@*;
    my $b;
    for my $i (0..$#mat-1) {
        for my $k (0..$mat[0]->$#*-1) {
            $b->[$i][$k] =    $mat[$i][$k]+$mat[$i][$k+1]
                            + $mat[$i+1][$k]+$mat[$i+1][$k+1];
        }
    }
    return $b;
}

use Test2::V0;
is(ss([
        [1,  2,  3,  4],
        [5,  6,  7,  8],
        [9, 10, 11, 12]
      ]),
    [
     [14, 18, 22],
     [30, 34, 38]
    ]
);

is(ss( [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
       ]),
    [
     [2, 1, 0],
     [1, 2, 1],
     [0, 1, 2]
    ]
);
done_testing();
