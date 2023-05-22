# https://theweeklychallenge.org/blog/perl-weekly-challenge-217/#TASK2
use v5.36;
sub task2 ( @integers ) {
    return join '', sort { "$b$a" <=> "$a$b" } @integers;
}


my @tests = (
    [    231, [1, 23]          ],
    [   3210, [10, 3, 2]       ],
    [ 431210, [31, 2, 4, 10]   ],
    [ 542111, [5, 11, 4, 1, 2] ],
    [    110, [1, 10]          ],

    # Without this test case, padding-with-tilde-to-maximum-size looks like a viable solution.
    [    131, [1, 13]          ],

    # These tests break other pad-to-maximum-size algorithms.
    [  10100, [  10, 100] ],
    [  10100, [ 100,  10] ],

    # Input sizes that choke permutation-based algortihms.
    [ 9908172635445362718, [ map 9 * $_, 1..10 ] ],
    [ '999989796959493929190898888786858483828180797877776757473727170696867666656463626160595857565555453525150494847464544443424140393837363534333323130292827262524232222120191817161514131211110100', [ 1..100 ] ],
);

use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ( $expected, $in ) = @{$_};
    is task2(@{$in}), $expected;
}
