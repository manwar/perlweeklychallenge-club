#!/usr/bin/env raku
use v6.d;

my Str:D @INPUT = ("Perl and Raku belong to the same family.",
             "I love Perl.",
             "The Perl and Raku Conference.");

sub MAIN(*@input) {
    @input = @INPUT unless @input.elems;

    say "Max words: " ~ max @input».words».elems.max;
}


