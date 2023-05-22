use strict;
use warnings;
use feature 'say';

sub find_third_smallest {
    return (sort { $a <=> $b } map { @$_ } @_)[2];
}

for my $test ( [ [3, 1, 2], [5, 2, 4], [0, 1, 3] ],
               [ [2, 1], [4, 5] ],
               [ [1, 0, 3], [0, 0, 0], [1, 2, 1] ] ) {
    print map "[@$_] ", @$test;
    say " => ", find_third_smallest @$test;
}
