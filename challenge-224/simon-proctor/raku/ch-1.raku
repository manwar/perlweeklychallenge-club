#!/usr/bin/env raku

#| Print whether the target string can be made from the characters in the source string
sub MAIN( Str $source, Str $target ) {
    ($target.comb.Bag (<=) $source.comb.Bag).lc.say;
}
