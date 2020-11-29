use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util 'reduce';

sub array_of_product(@n) {
    [ map {
        @{$_} == 0 ? 0 : reduce { $a * $b } @{$_}
    } 
    map { 
        my $idx = $_;
        [ map { $n[$_] } grep { $idx != $_ } 0 .. @n - 1 ]
    } 0 .. @n - 1 ]
}

if (@ARGV > 0) {
    say join q(, ), array_of_product(@ARGV)->@*;
    exit 0;
}

use Test::More;

is_deeply array_of_product(999), [0], 'One element returns 0';
is_deeply array_of_product(999, 888), [888, 999], 'Two elements invert positions';
is_deeply array_of_product(5, 2, 1, 4, 3), [24, 60, 120, 30, 40], 'Example 1';
is_deeply array_of_product(2, 1, 4, 3), [12, 24, 6, 8], 'Example 2';

done_testing;
