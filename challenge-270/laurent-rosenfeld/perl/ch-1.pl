use strict;
use warnings;
use feature 'say';

sub special_positions {
    my $mat = shift;
    my $row_max = $#{$mat->[0]};
    my $col_max =  $#{$mat};
    my $count = 0;
    for my $i (0..$row_max) {
    IND_J: for my $j (0..$col_max) {
            next if $mat->[$i][$j] != 1;
            # check row
            for my $m (0..$row_max) {
                next if $m == $i;
                next IND_J unless $mat->[$m][$j] == 0;
            }
            # check column
            for my $k (0..$col_max) {
                next if $k == $j;
                next IND_J unless $mat->[$i][$k] == 0;
            }
            # say "$i, $j"; # uncomment to see the positions
            $count++;
        }
    }
    return $count;
}

my @tests = (
        [ [1, 0, 0],
          [0, 0, 1],
          [1, 0, 0],
        ],
        [ [1, 0, 0],
          [0, 1, 0],
          [0, 0, 1],
        ]
        );
for my $test (@tests) {
    printf "[%-8s %-8s ...] => ", "@{$test->[0]}", "@{$test->[1]}";
    say special_positions $test;
}
