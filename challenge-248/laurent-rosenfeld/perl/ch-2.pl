use strict;
use warnings;
use feature 'say';

sub submatrix_sum {
    my @in = @_;
    my $max_row = $#in - 1;
    my $max_col = $#{$in[0]};
    my @result;
    for my $i (0..$max_row ) {
        my @row;
        for my $j (0..$max_col - 1) {
            push @row, $in[$i][$j] + $in[$i][$j+1] +
                $in[$i+1][$j] + $in[$i+1][$j+1];
        }
        push @result, [@row];
    }
    return @result;
}

my @tests = ([
              [1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]
             ],
             [
              [1, 0, 0, 0],
              [0, 1, 0, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 1]
             ]);
for my $test (@tests) {
    print join ", ", map { "[@$_]" } @$test;
    print " => ";
    say join ", ", map { "[@$_]" } submatrix_sum @$test;
}
