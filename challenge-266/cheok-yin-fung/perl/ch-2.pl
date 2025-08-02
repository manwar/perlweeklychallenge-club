# The Weekly Challenge 266
# Task 2 X Matrix
use v5.30.0;
use warnings;

sub xm {
    my $matrix = $_[0];
    my $dim0 = $matrix->$#*;
    for my $i (0..$dim0) {
        for my $j (0..$dim0) {
            if ($i == $j || $i+$j == $dim0) {
                return 0 if $matrix->[$i]->[$j] == 0; 
            } 
            else {
                return 0 if $matrix->[$i]->[$j] != 0;
            }
        }
    }
    return 1;
}

use Test::More tests=>3;
ok xm(
                [ [1, 0, 0, 2],
                   [0, 3, 4, 0],
                   [0, 5, 6, 0],
                   [7, 0, 0, 1],
                 ]
      ) 
    == 1;

ok xm(
                [ [1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9],
                 ]
      )
    == 0;

ok xm(
                 [ [1, 0, 2],
                   [0, 3, 0],
                   [4, 0, 5],
                 ]
      )
    == 1;
