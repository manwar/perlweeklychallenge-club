use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub _gcd($a, $b) {
    return $b ? _gcd($b, $a % $b) : $a
}

sub _gcd_sum($list, $i, $j, $acc) {
    return $acc if $i == $list->@*;

    @_ = $j == $list->@*
        ? ($list, $i + 1, $i + 2, $acc)
        : ($list, $i, $j + 1, $acc + _gcd($list->[$i], $list->[$j]));

    goto &_gcd_sum;
}

sub gcd_sum($n) {
    _gcd_sum [ 1 .. $n ], 0, 1, 0
}

######## MAIN and TESTS ########

if (@ARGV == 1) {
    say gcd_sum(shift);
    exit 0
}

use Test::More;

is gcd_sum(3), 3, 'gcd-sum of 3';
is gcd_sum(4), 7, 'gcd-sum of 4';

done_testing;
