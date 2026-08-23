#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

sub trailing_zeros ($n) {
    return 0 if $n <= 0;

    my $count   = 0;
    my $divisor = 5;
    while ( $n >= $divisor ) {
        $count += int( $n / $divisor );
        $divisor *= 5;
    }
    return $count;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( trailing_zeros(10), 2, 'Example 1 (N=10)' );
    is( trailing_zeros(7),  1, 'Example 2 (N=7)' );
    is( trailing_zeros(4),  0, 'Example 3 (N=4)' );
    is( trailing_zeros(25), 6, 'Multiple of 25 (N=25)' );

    done_testing();
}

