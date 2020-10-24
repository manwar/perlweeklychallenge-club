#!/usr/bin/perl

=pod
Example 1:

Input: @A = (3, 10, 8)
Output: 1

Explanation:

Flipping the sign of just one element 10 gives the result 1 i.e. (3) + (-10) + (8) = 1

Example 2:

Input: @A = (12, 2, 10)
Output: 1

Explanation:

Flipping the sign of just one element 12 gives the result 0 i.e. (-12) + (2) + (10) = 0
=cut

use v5.30;
use warnings;
use experimental 'smartmatch';

use Test::More tests => 4;

sub test {
    $_ = `perl ch-2.pl @_`;
    chomp;
    return $_;
}

# Tests.
is &test( 3,   10, 8 ),   1;
is &test( 12,  2,  10 ),  1;
is &test( -12, -2, -10 ), 1;

# The following series has two possible solutions: 2 and 5.
ok &test( 1, 2, 3, 4, 5, 6, 9 ) ~~ [ 2, 5 ];
