#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Smallest String
# Given string $s and integer $k > 0, repeatedly choose one of the first $k
# letters and append it to the end until lexicographically smallest.

sub smallest_string ( $s, $k ) {
    my $len = length($s);
    return $s if $len <= 1;

    if ( $k > 1 ) {
        # With k >= 2, any permutation can be achieved (equivalent to Bubble Sort rotations)
        return join( '', sort split //, $s );
    }

    # With k == 1, only cyclic rotations are possible
    my $smallest = $s;
    my $curr     = $s;

    for ( 1 .. $len - 1 ) {
        $curr     = substr( $curr, 1 ) . substr( $curr, 0, 1 );
        $smallest = $curr if $curr lt $smallest;
    }

    return $smallest;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( smallest_string( "dbca",     1 ), "adbc",     "Example 1" );
    is( smallest_string( "geeks",    2 ), "eegks",    "Example 2" );
    is( smallest_string( "cbaed",    3 ), "abcde",    "Example 3" );
    is( smallest_string( "fedcba",   4 ), "abcdef",   "Example 4" );
    is( smallest_string( "perl",     1 ), "erlp",     "Example 5" );
    is( smallest_string( "oloolooo", 1 ), "looloooo", "Example 6" );
    is( smallest_string( "oloooolo", 1 ), "looloooo", "Example 7" );

    done_testing();
}
else {
    my $s = $ARGV[0];
    my $k = int( $ARGV[1] // 1 );
    say smallest_string( $s, $k );
}
