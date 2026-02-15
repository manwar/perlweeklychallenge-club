#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 360 Task 1: Text Justifier
#
#       Perl solution by Matthias Muth.
#

use v5.36;

# Left-then-right approach.
sub text_justifier_LR( $str, $width ) {
    $str = "*" x ( ( $width - length( $str ) ) / 2 ) . $str;
    return $str . "*" x ( $width - length( $str ) );
}

# Iterative approach.
sub text_justifier_iter( $str, $width ) {
    $str = length( $str ) % 2 == 0 ? "${str}*" : "*${str}"
        while length( $str ) < $width;
    return $str;
}

# Insertion approach.
sub text_justifier_insert( $str, $width ) {
    my $combined = "*" x ( $width - length( $str ) );
    substr $combined, length( $combined ) / 2, 0, $str;
    return $combined;
}

# Distribution approach.
sub text_justifier_distrib( $str, $width ) {
    my $padding = "*" x ( $width - length( $str ) );
    $str = substr( $padding, 0, length( $padding ) / 2, "" ) . $str;
    return $str . $padding;
}

# Once-and-done approach.
sub text_justifier_in_one( $str, $width ) {
    my $n = ( $width - length( $str ) ) >> 1;
    return "*" x $n . $str . "*" x ( $width - length( $str ) - $n );
}

my $sub_base_name = "text_justifier";

my @tests = (
    [ 'Example 1:', [ "Hi", 5 ],    [ "*Hi**" ]      ],
    [ 'Example 2:', [ "Code", 10 ], [ "***Code***" ] ],
    [ 'Example 3:', [ "Hello", 9 ], [ "**Hello**" ]  ],
    [ 'Example 4:', [ "Perl", 4 ],  [ "Perl" ]       ],
    [ 'Example 5:', [ "A", 7 ],     [ "***A***" ]    ],
    [ 'Example 6:', [ "", 5 ],      [ "*****" ]      ],
);

my @benchmark_params = ( "somestring", 100 );

use lib '.';
use MultiTest;
run( $sub_base_name, \@tests, \@benchmark_params );
