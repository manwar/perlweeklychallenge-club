#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-031/
# Task #1
# Create a function to check divide by zero error
# without checking if the denominator is zero.

use strict;
use warnings;

sub is_division_by_zero {
    my ($num,$den) = @_;
    return if ( eval { $num = $num/$den; 1 } );
    return 1;
}

print 'Division by zero' if is_division_by_zero(1,0);
