#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 366 Task 2: Valid Times
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub valid_times( $time ) {
    $time =~ /^ ( [?01][?0-9] | 2[?0-3] ) : [?0-5] [?0-9] $/x
        or return 0;
    my ( $h10, $h1, $m10, $m1 ) = unpack "AAxAA", $time;
    return
        ( $h10 eq "?"
            ? ( $h1 eq "?"
                ? 24
                : $h1 <= 3 ? 3 : 2 )
            : $h1 eq "?"
                ? ( $h10 == 2 ? 4 : 10 )
                : 1 )
        * ( $m10 eq "?" ? 6 : 1 )
        * ( $m1  eq "?" ? 10 : 1 );
}

use Test2::V0 qw( -no_srand );

is valid_times( "?2:34" ), 3,
    'Example 1: valid_times( "?2:34" ) == 3';
is valid_times( "?4:?0" ), 12,
    'Example 2: valid_times( "?4:?0" ) == 12';
is valid_times( "??:??" ), 1440,
    'Example 3: valid_times( "??:??" ) == 1440';
is valid_times( "?3:45" ), 3,
    'Example 4: valid_times( "?3:45" ) == 3';
is valid_times( "2?:15" ), 4,
    'Example 5: valid_times( "2?:15" ) == 4';

done_testing;
