use strict;
use warnings;
use feature 'say';

sub running_sum {
    my @sum = shift;
    for my $item (@_) {
        push @sum, $item + $sum[-1];
    }
    return @sum;
}

my @tests = ([<1 2 3 4 5>], [<1 1 1 1 1>], [<0 -1 1 2>]);
for my $test (@tests) {
    printf "%-15s => ", "@$test";
    say join ", ", running_sum @$test;
}
