#!/usr/bin/env raku

use v6;

#| Given an inflaction point and a list of values put all the items less than the inflection point
#| at the start of the last and all those great or equal after. Retain ordering.
sub MAIN (
    Int $inflection, #= Inflection point
    *@rest where .all ~~ Int #= List of values 
) {
    my %c = @rest.classify( * >= $inflection );
    ( |%c{False}, |%c{True} ).say;
}
