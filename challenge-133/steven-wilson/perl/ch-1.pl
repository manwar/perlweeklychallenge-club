#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @test_input  = qw/ 10 27 85 101 /;
my @test_output = qw/ 3 5 9 10 /;

foreach my $i ( 1 .. ( scalar @test_input ) ) {
    ok( find_isqrt( $test_input[ $i - 1 ] ) == $test_output[ $i - 1 ], "test $i" );
}
done_testing();

sub find_isqrt {
    my $input = shift;
    my $x     = $input;
    use integer;
    my $y = ( $x + 1 ) / 2;
    while ( $y < $x ) {
        $x = $y;
        $y = ( ( $x + $input / $x ) / 2 );
    }
    return $x;
}
