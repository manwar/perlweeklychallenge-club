#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Rearrange Binary String
# Simultaneously replace all "01" with "10" until no "01" exists.
# Return the total number of steps taken.

sub rearrange_binary_string ($str) {
    my $steps = 0;
    while ( $str =~ /01/ ) {
        $str =~ s/01/10/g;
        $steps++;
    }
    return $steps;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( rearrange_binary_string("111000"), 0, "Example 1" );
    is( rearrange_binary_string("00011"),  4, "Example 2" );
    is( rearrange_binary_string("01011"),  3, "Example 3" );
    is( rearrange_binary_string("010101"), 3, "Example 4" );
    is( rearrange_binary_string("00001"),  4, "Example 5" );

    done_testing();
}
else {
    say rearrange_binary_string( $ARGV[0] );
}
