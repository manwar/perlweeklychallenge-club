#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples =
    ( [ 3, 1, 4, 2 ], [ 1, 2, 3, 4 ], [ 1, 3, 2, 4, 6, 5 ], [ 1, 3, 4, 2 ], );

for my $ex (@examples) {
    my @e = $ex->@*;
    my $e = join ', ', @e;
    my @o = pattern_finder(@e);
    my $o = join ', ', @o;
    say <<"END";
    Input:  \@list = ($e)
    Output: ($o)
END
}

sub pattern_finder ( @array ) {
    for my $i ( 0 .. -3 + scalar @array ) {
        for my $j ( $i + 1 .. -2 + scalar @array ) {
            for my $k ( $j + 1 .. -1 + scalar @array ) {
                my $ai = $array[$i];
                my $aj = $array[$j];
                my $ak = $array[$k];
                if ( $ai < $ak && $ak < $aj ) {
                    return ( $ai, $aj, $ak );
                }
            }
        }
    }
    return ();
}
