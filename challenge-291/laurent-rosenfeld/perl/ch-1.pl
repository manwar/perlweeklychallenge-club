use strict;
use warnings;
use feature 'say';

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub middle_index {
    for my $i (0..$#_) {
        return $i if sum(@_[0..$i]) == sum(@_[$i..$#_]);
    }
    return -1;
}
my @tests = ( [2, 3, -1, 8, 4], [1, -1, 4], [2, 5]);
for my $test (@tests) {
    printf "%-12s => ", "@$test";
    say middle_index @$test;
}
