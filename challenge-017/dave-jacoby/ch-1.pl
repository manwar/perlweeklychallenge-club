#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

say a( 1, 2 );
say a( 2, 2 );
say a( 2, 5 );
exit;

sub a ( $m, $n ) {
    die 'Invalid input' unless $m >= 0 && $n >= 0;
    return $n + 1 if $m == 0;
    return a( $m - 1, 1 ) if $m > 0 && $n == 0;
    return a( $m - 1, a( $m, $n - 1 ) ) if $m > 0 && $n > 0;
}

