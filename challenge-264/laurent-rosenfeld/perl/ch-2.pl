use strict;
use warnings;
use feature 'say';

sub target_array  {
    my @source = @{$_[0]};
    my @indices = @{$_[1]};
    my @target;
    for my $i (0..$#source) {
        splice @target, $indices[$i], 0,  $source[$i];
    }
    return @target;
}

my @tests = ( [ [0, 1, 2, 3, 4], [0, 1, 2, 2, 1] ],
              [ [1, 2, 3, 4, 0], [0, 1, 2, 3, 0] ],
              [ [1,], [0,] ] );
for my $test (@tests) {
    printf "%-10s - %-10s => ", "@{$test->[0]}", "@{$test->[1]}";
    say join " ", target_array $test->[0], $test->[1];
}
