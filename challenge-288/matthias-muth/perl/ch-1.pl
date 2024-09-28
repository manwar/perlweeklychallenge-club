#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 288 Task 1: Closest Palindrome
#
#       Perl solution by Matthias Muth.
#

use v5.36;

our $verbose = 0;
sub vsay( @args ) { say @args if $verbose };

sub closest_palindrome_1( $str ) {
    # Searching in two directions: down and up, until we find a number
    # that is a palindrome.
    for ( my $distance = 1; ; ++$distance ) {
        for my $try ( $str - $distance, $str + $distance ) {
            return $try
                if reverse( $try ) eq $try;
        }
    }
    # We should never get here,
    # we should have found a single digit 'palindrome' at least!
    warn "INTERNAL ERROR: There's something wrong with this algorithm!\n";
    return undef;
}

sub closest_palindrome( $str ) {
    return undef unless $str =~ /^-?[0-9]+$/;

    # Edge case: negative numbers.
    return "0" if $str < 0;

    my $left_part = substr( $str, 0, int( ( length( $str ) + 1 ) / 2 ) );
    my ( $closest, $closest_distance ) = ( undef, undef );
    for my $try ( $left_part - 1, $left_part, $left_part + 1 ) {
        next unless $try >= 0;    # Edge case on input '0'.
        my $palindrome =
            length $try < length $left_part
                ? '9' x ( length( $str ) - 1 ) :
            length $try > length $left_part
                ? ( '1' . ( '0' x ( length( $str ) - 1 ) ) . '1' )
                : ( $try
                    . substr( reverse( $try ), length( $str ) % 2 ) );
        my $distance = abs( $palindrome - $str );
        if ( $palindrome != $str
            && ( ! defined $closest_distance
                ||  $distance < $closest_distance ) )
        {
            $closest = $palindrome;
            $closest_distance = abs( $palindrome - $str );
        }
    }
    return $closest;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

my $sub_name = "closest_palindrome";
my @tests = (
    [ 'Example 1:', 123, 121 ],
    [ 'Example 2:', 2, 1 ],
    [ 'Example 3:', 1400, 1441 ],
    [ 'Example 4:', 1001, 999 ],
    [ 'Extra 1:', 1, 0 ],
    [ 'Extra 1:', 0, 1 ],
    [ 'Extra 2:', -5, 0 ],
    [ 'Extra 3:', 9999, 10001 ],
    [ 'Extra 4:', 10001, 9999 ],
    [ 'Extra 5:', 99999, 100001 ],
    [ 'Extra 6:', 100001, 99999 ],
    [ 'Extra 7:', 345678, 345543 ],
);

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "\n", "Testing $sub:\n", "\n";
    for ( @tests ) {
        my ( $descr, $input, $output ) = $_->@*;
        $descr .= " " . pp( $input ) . " => $output"
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
        is $sub->( $input ), $output, $descr;
    }
}
done_testing;

__END__

use Test2::V0 qw( -no_srand );
is closest_palindrome( 123 ), 121,
    'Example 1: closest_palindrome( 123 ) == 121';
is closest_palindrome( 2 ), 1,
    'Example 2: closest_palindrome( 2 ) == 1';
is closest_palindrome( 1400 ), 1441,
    'Example 3: closest_palindrome( 1400 ) == 1441';
is closest_palindrome( 1001 ), 999,
    'Example 4: closest_palindrome( 1001 ) == 999';
is closest_palindrome( 1 ), 0,
    'Extra 1: closest_palindrome( 1 ) == 0';
is closest_palindrome( 0 ), 1,
    'Extra 1: closest_palindrome( 0 ) == 1';
is closest_palindrome( -5 ), 0,
    'Extra 2: closest_palindrome( -5 ) == 0';
is closest_palindrome( 9999 ), 10001,
    'Extra 3: closest_palindrome( 9999 ) == 10001';
is closest_palindrome( 10001 ), 9999,
    'Extra 4: closest_palindrome( 10001 ) == 9999';
is closest_palindrome( 99999 ), 100001,
    'Extra 5: closest_palindrome( 99999 ) == 100001';
is closest_palindrome( 100001 ), 99999,
    'Extra 6: closest_palindrome( 100001 ) == 99999';
is closest_palindrome( 345678 ), 345543,
    'Extra 7: closest_palindrome( 345678 ) == 345543';
done_testing;
