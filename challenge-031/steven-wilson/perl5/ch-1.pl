#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-22
# Week: 031

# Task #1
# Create a function to check divide by zero error without checking if
# the denominator is zero.

use strict;
use warnings;
use feature qw/ say /;
use Test::More;

ok( is_divide_by_zero( 1, 0 ) == 1, "Test zero denominator" );
ok( is_divide_by_zero( 1, 1 ) == 0, "Test non-zero denominator" );
done_testing();

sub is_divide_by_zero {
    my ( $numerator, $denominator ) = @_;
    eval { my $answer = $numerator / $denominator; };
    if ( $@ =~ /Illegal division by zero/ ) {
        return 1;
    }
    else {
        return 0;
    }
}
