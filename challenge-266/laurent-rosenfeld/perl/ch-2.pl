use strict;
use warnings;
use feature 'say';

sub is_x_matrix {
    my $m = shift;
    my $end = scalar @{$m->[0]} - 1; # $end = size - 1
    for my $i (0..$end) {
        for my $j (0..$end) {
            if ($i == $j or $i + $j == $end) { # diag or antidiag
                return "false" if $m->[$i][$j] == 0;
            } else {    # not diag or antidiag
                return "false" if $m->[$i][$j] != 0;
            }
        }
    }
    # If we got here, it is an X-matrix
    return "true";
}

my @tests = (
    [ [1, 0, 0, 2],
      [0, 3, 4, 0],
      [0, 5, 6, 0],
      [7, 0, 0, 1],
    ],
    [ [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ],
    [ [1, 0, 2],
      [0, 3, 0],
      [4, 0, 5],
    ]
    );
for my $test (@tests) {
    printf "[%-10s...] => ", "@{$test->[0]}";
    say is_x_matrix $test;
}
