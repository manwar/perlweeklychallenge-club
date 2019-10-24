#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ say state };
use experimental qw{ postderef signatures switch };

use Try::Tiny;

# notice the slightly more compact header

# TASK #1

# Create a function to check divide by zero error
# without checking if the denominator is zero.

say div_zero_check( 1, 2 ) ? 'Divide by zero' : 'OK';

say div_zero_check( 1, 0 ) ? 'Divide by zero' : 'OK';

say div_zero_check( 0, 1 ) ? 'Divide by zero' : 'OK';

# If we can't pre-check, we can post-check. Perl will correctly
# throw an error, so $result will remain 0.
# Otherwise we check the $result AND the numerator, because 
# 0/4 will still be zero, but will not be an error

sub div_zero_check ( $numerator, $denominator ) {
    my $result = 0;
    try { $result = $numerator / $denominator; }
    catch { 1 };

    if ( $result == 0 && $numerator != 0 ) {
        return 1;
    }
    return 0;
}
