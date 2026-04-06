#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Prime::Util qw{ factor factor_exp };

my @F = (\&factor_exp, \&factor);
sub big_and_little_omega($number, $mode) {
    return scalar($F[ !! $mode ]($number))
}

use Test::More tests => 5 + 2;

is big_and_little_omega(100061, 0), 3, 'Example 1';
is big_and_little_omega(971088, 0), 3, 'Example 2';
is big_and_little_omega( 63640, 1), 6, 'Example 3';
is big_and_little_omega(988841, 1), 2, 'Example 4';
is big_and_little_omega(211529, 0), 2, 'Example 5';

is big_and_little_omega(3 ** 3 * 5 ** 3, 0), 2, '3**3*5**3,0';
is big_and_little_omega(3 ** 3 * 5 ** 3, 1), 6, '3**3*5**3,1';
