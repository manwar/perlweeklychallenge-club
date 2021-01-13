#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(signatures say);
no warnings qw(experimental::signatures);

use Scalar::Util qw(looks_like_number);
use List::Util qw(any min max);

# You are given an array of positive numbers @A.
#
# Write a script to find the larget rectangle histogram created by the given array.
# BONUS: Try to print the histogram as shown in the example, if possible.

my ( @A ) = @ARGV;

@A = ( 2, 1, 4, 5, 3, 7 ) unless @A;

if ( any { !looks_like_number( $_ ) || $_ < 0 } ( @A ) ) {
    usage();
    exit 1;
}

print_histogram( @A );

say largest_rectangle( @A );

exit 0;

sub largest_rectangle(@cols) {
    return 0 unless @cols;

    max(
        rectangle_size( @cols ),
        largest_rectangle( @cols[ 1 .. $#cols ] ),
        largest_rectangle( @cols[ 0 .. ( $#cols - 1 ) ] )
    );
}

sub rectangle_size(@cols) {
    return scalar @cols * min @cols;
}

sub print_histogram(@cols) {
    my $height = max @cols;

    while ( $height ) {
        say join( ' ', $height, map { $_ >= $height ? '#' : ' ' } @cols );
        $height--;
    }

    say join( ' ', map { '_' } ( 0 .. @cols ) );
    say join( ' ', ' ', @cols );
}

sub usage() {
    say <<END
$0 [A]

  [A] An array of positive integers
END
}

