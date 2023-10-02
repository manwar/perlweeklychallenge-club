use strict;
use warnings;
use feature 'say';

sub can_strictly_increase {
    my $count = 0;
    for my $i (1..$#_) {
        $count++ if $_[$i-1] >= $_[$i];
    }
    return $count > 1 ? "false" : "true";
}

for my $test ([<0 2 9 4 6>], [<5 1 3 2>],
              [<2 2 3>], [<3 3 3>]) {
    printf "%-12s => ", "@$test";
    say can_strictly_increase @$test;
}
