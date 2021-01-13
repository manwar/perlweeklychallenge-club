#!/usr/bin/env raku

use v6.d;

#| Given a string and a list of other strings return those in the main string in order
sub MAIN (
    Str $haystack, #= Target string to search
    *@needles #= Strings to search for
) {
    .say for ( @needles.map( { $_ => $haystack.index($_) } ).grep( { $_.value.defined } ).sort( { $^a.value <=> $^b.value } ).map( *.key ) ) || [0];
}
