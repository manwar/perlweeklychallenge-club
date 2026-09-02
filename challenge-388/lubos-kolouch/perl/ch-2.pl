#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Secret Santa
# Return the total number of valid gift assignments where no employee
# receives the gift they originally bought (derangements).

sub secret_santa ($n) {
    return 0 if $n <= 1;
    return 1 if $n == 2;

    my $prev2 = 0;    # D(1)
    my $prev1 = 1;    # D(2)
    my $curr  = 1;

    for my $i ( 3 .. $n ) {
        $curr  = ( $i - 1 ) * ( $prev1 + $prev2 );
        $prev2 = $prev1;
        $prev1 = $curr;
    }

    return $curr;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( secret_santa(1), 0,   'Example 1' );
    is( secret_santa(2), 1,   'Example 2' );
    is( secret_santa(3), 2,   'Example 3' );
    is( secret_santa(4), 9,   'Example 4' );
    is( secret_santa(5), 44,  'Example 5' );
    is( secret_santa(6), 265, 'n = 6' );

    done_testing();
}
else {
    my $n = int( $ARGV[0] );
    say secret_santa($n);
}
