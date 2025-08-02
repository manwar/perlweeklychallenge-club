#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 326 Task 1: Day of the Year
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Time::Piece;

sub day_of_the_year( $date ) {
    return Time::Piece->strptime( $date, "%F" )->day_of_year + 1;
}

use Test2::V0 qw( -no_srand );

is day_of_the_year( "2025-02-02" ), 33,
    'Example 1: day_of_the_year( "2025-02-02" ) == 33';
is day_of_the_year( "2025-04-10" ), 100,
    'Example 2: day_of_the_year( "2025-04-10" ) == 100';
is day_of_the_year( "2025-09-07" ), 250,
    'Example 3: day_of_the_year( "2025-09-07" ) == 250';

done_testing;
