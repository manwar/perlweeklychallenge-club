use strict;
use warnings;
use feature 'say';

sub bitwise_or {
    my @evens = grep { $_ % 2 == 0} @_;
    return scalar @evens >= 2 ? "True" : "False";
}

my @tests = ([1, 2, 3, 4, 5], [2, 3, 8, 16], [1, 2, 5, 7, 9]);
for my $test (@tests) {
    printf "%-12s => ", "@$test";
    say bitwise_or @$test;
}
