#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(sum0);

use FindBin;
use lib File::Spec->join( $FindBin::RealBin, '..', '..', '..', 'challenge-083', 'alexander-pankoff', 'perl', 'lib' );

use Combinations qw(combinations);

{
    my ( $N ) = @ARGV;
    say gcd_sum( $N );
}

sub gcd_sum($up_to) {
    return sum0( map { gcd( $_->[0], $_->[1] ) } unique_pairs( 1 ... $up_to ) );
}

sub unique_pairs(@xs) {
    combinations( 2, @xs );
}

# euclids algorithm
sub gcd ( $x, $y ) {
    return $x if $y == 0;
    return gcd( $y, $x % $y );
}
