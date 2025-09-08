use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($arr1, $arr2) {
    my @arr1 = sort {$a <=> $b} @$arr1;
    my @arr2 = sort {$a <=> $b} @$arr2;

    my $d1 = abs($arr1[0] - $arr2[-1]);
    my $d2 = abs($arr2[0] - $arr1[-1]);

    return $d1 > $d2 ? $d1 : $d2;
}

is(run([4, 5, 7], [9, 1, 3, 4]), 6, "Example 1");
is(run([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]), 6, "Example 2");
is(run([2, 1, 11, 3], [2, 5, 10, 2]), 9, "Example 3");
is(run([1, 2, 3], [3, 2, 1]), 2, "Example 4");
is(run([1, 0, 2, 3], [5, 0]), 5, "Example 5");
