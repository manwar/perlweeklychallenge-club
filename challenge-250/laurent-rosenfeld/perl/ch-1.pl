use strict;
use warnings;
use feature 'say';

sub smallest_index {
    my @in = @_;
    for my $i (0..$#in) {
        return $i if $i % 10 == $in[$i];
    }
    return -1
}

for my $test ([0, 1, 2], [4, 3, 2, 1],
    [qw/1 2 3 4 5 6 7 8 9 0/]) {
    printf "%-20s => ", "@$test";
    say smallest_index @$test;
}
