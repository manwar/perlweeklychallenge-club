use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($digits, $n) {
    return 0 if grep /^[^01]$/, @$digits;
    for (my $i = 0; $i < $#$digits; $i++) {
        if ($digits->[$i] == $digits->[$i+1]) {
            return 0 if $digits->[$i] == 1;
            $digits->[$i+1] = 1;
            $n -= 1;
        }
    }
    return $n == 0 || 0;
}

is(run([1, 0, 0, 0, 1], 1), 1, "Example 1");
is(run([1, 0, 0, 0, 1], 2), 0, "Example 2");
is(run([1, 0, 1, 0, 1], 0), 1, "Example 3");
is(run([3, 0, 0, 0, 1], 1), 0, "Example with invalid list");
