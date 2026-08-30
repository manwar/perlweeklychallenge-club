#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 388 Task 1: Dyck Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub dyck_words_q( $n ) {
    my @results;
    my ( $string, $height, $u_used ) = ( "", 0, 0 );
    my @q = ( [ $string, $height, $u_used ] );
    while ( @q ) {
        ( $string, $height, $u_used ) = ( shift @q )->@*;
        if ( length( $string ) == 2 * $n ) {
            push @results, $string;
        }
        else {
            push @q, [ $string . "D", $height - 1, $u_used ]
                if $height > 0;
            push @q, [ $string . "U", $height + 1, ++$u_used ]
                if $u_used < $n;
        }
    }
    return @results;
}

sub dyck_words_rec( $n, $h = 0 ) {
    return "" if $n == 0 && $h == 0;
    return (
        $h > 0 ? ( map { "D" . $_ } dyck_words_rec( $n, $h - 1 ) ) : (),
        $n > 0 ? ( map { "U" . $_ } dyck_words_rec( $n - 1, $h + 1 ) ) : ()
    );
}

use lib qw( . ../../../lib );
use MultiTest;

my @tests = (
    [ "Example 1", 1, ["UD"] ],
    [ "Example 2", 2, ["UDUD", "UUDD"] ],
    [ "Example 3", 3, ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"] ],
    [ "Example 4", 0, [""] ],
    [ "Example 5", 4,
        [ "UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
          "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
          "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD", ]
    ],
);

my @benchmark_data = ( 6 );
run( "dyck_words", \@tests, \@benchmark_data );
