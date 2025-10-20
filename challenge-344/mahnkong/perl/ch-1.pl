use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($ints, $x) {
    return [ split("", join('', @$ints) + $x) ];
}

is_deeply(run([1,2,3,4], 12), [1,2,4,6], "Example 1");
is_deeply(run([2,7,4], 181), [4,5,5], "Example 2");
is_deeply(run([9,9,9], 1), [1,0,0,0], "Example 3");
is_deeply(run([1,0,0,0,0], 9999), [1,9,9,9,9], "Example 4");
is_deeply(run([0], 1000), [1,0,0,0], "Example 5");
