use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($array_1, $array_2) {
    my %array_2 = map { $_ => 1 } @$array_2;
    foreach my $i (sort { $a <=> $b } @$array_1) {
        return $i if exists $array_2{$i};
    }
    return -1;
}

is(run([1, 2, 3, 4], [3, 4, 5, 6]), 3, "Example 1");
is(run([1, 2, 3], [2, 4]), 2, "Example 2");
is(run([1, 2, 3, 4], [5, 6, 7, 8]), -1, "Example 3");
