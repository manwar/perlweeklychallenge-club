#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

sub swap_chars ( $s, $c, $o ) {
    my $n = length($s);
    return $s if $n == 0;

    for my $i ( 1 .. $c ) {
        my $x = $i % $n;
        my $y = ( $i + $o ) % $n;
        substr( $s, $x, 1, substr( $s, $y, 1, substr( $s, $x, 1 ) ) );
    }

    return $s;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( swap_chars( 'perlandraku', 3, 4 ), 'pndraerlaku', 'Example test' );
    is( swap_chars( 'a',           3, 4 ), 'a',           'Single char' );
    is( swap_chars( 'perlandraku', 0, 4 ), 'perlandraku', 'Zero swaps' );

    done_testing();
}
