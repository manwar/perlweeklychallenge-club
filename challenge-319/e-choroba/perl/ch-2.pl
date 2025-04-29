#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub minimum_common($arr1, $arr2) {
    my %intersection;
    @intersection{ @$arr1 } = (1) x @$arr1;
    ++$intersection{$_} for @$arr2;
    delete @intersection{ grep $intersection{$_} == 1, keys %intersection };
    undef $intersection{-1} unless keys %intersection;

    return min(keys %intersection)
}

use Test::More tests => 3 + 2;

is minimum_common([1, 2, 3, 4], [3, 4, 5, 6]), 3, 'Example 1';
is minimum_common([1, 2, 3], [2, 4]), 2, 'Example 2';
is minimum_common([1, 2, 3, 4], [5, 6, 7, 8]), -1, 'Example 3';

is minimum_common([1, 1, 2], [2, 3, 3]), 2, 'Repeated values';
is minimum_common([-1, -2, -3], [-1, 0, 1]), -1, 'Semipredicate problem';
