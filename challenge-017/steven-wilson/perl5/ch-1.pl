#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-15
# Week: 017
#
# Task #1
# Create a script to demonstrate Ackermann function. The Ackermann
# function is defined as below, m and n are positive number:
#   A(m, n) = n + 1                  if m = 0
#   A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#   A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
# Example expansions as shown in wiki page.
# https://en.wikipedia.org/wiki/Ackermann_function
#  A(1, 2) = A(0, A(1, 1))
#          = A(0, A(0, A(1, 0)))
#          = A(0, A(0, A(0, 1)))
#          = A(0, A(0, 2))
#          = A(0, 3)
#          = 4

use strict;
use warnings;
use Memoize;
no warnings 'recursion';
use feature qw/ say /;
use Test::More;

ok( A( 1, 2 ) == 4, 'Test A(1, 2) == 4' );

done_testing();

# This gets past A(4,1) quicker but A(4,2) takes too long so don't run this script
memoize("A");

sub A {
    my ( $m, $n ) = @_;
    if ( $m == 0 ) {
        return $n + 1;
    }
    elsif ( $m > 0 and $n == 0 ) {
        return A( $m - 1, 1 );
    }
    elsif ( $m > 0 and $n > 0 ) {
        return A( $m - 1, A( $m, $n - 1 ) );
    }
}

my $number = 4;
for my $n ( 0 .. $number ) {
    for my $m ( 0 .. $number ) {
        say "A($m, $n) is ".  A( $m, $n );
    }
}
