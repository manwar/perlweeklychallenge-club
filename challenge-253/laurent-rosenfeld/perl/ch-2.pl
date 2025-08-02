use strict;
use warnings;
use feature 'say';

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub weakest_row {
    my @matrix = @_;
    my $row_end = @{$matrix[0]} -1;
    # Schwartzian transform
    return map { "$_->[0] " }
    sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0]}
    map { [ $_, sum @{$matrix[$_]} ] } 0..$row_end;
}

my @tests = ( [
                [1, 1, 0, 0, 0],
                [1, 1, 1, 1, 0],
                [1, 0, 0, 0, 0],
                [1, 1, 0, 0, 0],
                [1, 1, 1, 1, 1]
              ],
              [
                [1, 0, 0, 0],
                [1, 1, 1, 1],
                [1, 0, 0, 0],
                [1, 0, 0, 0]
              ]
            );

for my $test (@tests) {
    printf "%-10s ... %-10s => ",
        "@{$test->[0]}", "@{$test->[-1]}";
    say weakest_row @$test;
}
