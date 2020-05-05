#!/usr/bin/env raku

use v6;

#= Reads in user data and finds an ordering.
multi sub MAIN (
    Str $data where *.IO.f #= list of comma seperated heights and expected number before
) {
    my @heights = $data.IO.lines[0].split(",").map( *.Int );
    my @higher = $data.IO.lines[1].split(",").map( *.Int );

    say "Heights      {@heights}";
    say "Requirements {@higher}";

    my @combined = (@heights Z @higher).sort;
    my @final;
    my @indexes = ^@combined.elems;

    for @combined -> ( $height, $pos ) {
        @final[@indexes.splice( $pos, 1 )] = $height;
    }

    say "Final List   {@final}";
}
