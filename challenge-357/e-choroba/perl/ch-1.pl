#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use constant KAPREKAR => 6174;

sub kaprekar_constant($int) {
    return -1 if 0 == $int % 1111;
    my $steps = 0;

    while ($int != KAPREKAR) {
        ++$steps;
        my $k1 = join "", sort split //, $int;
        my $k2 = join "", sort { $b cmp $a } split //, $int;
        $int = sprintf '%04d', abs($k1 - $k2);
    }
    return $steps
}

use Test::More tests => 6 + 1;

is kaprekar_constant(3524), 3, 'Example 1';
is kaprekar_constant(6174), 0, 'Example 2';
is kaprekar_constant(9998), 5, 'Example 3';
is kaprekar_constant(1001), 4, 'Example 4';
is kaprekar_constant(9000), 4, 'Example 5';
is kaprekar_constant(1111), -1, 'Example 6';

is kaprekar_constant(6175), 7, 'The longest';
