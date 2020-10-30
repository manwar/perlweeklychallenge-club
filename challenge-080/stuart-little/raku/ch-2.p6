#!/usr/bin/env perl6
use v6;

sub candy(@a) {
    (@a Z- @a[1..*]).grep(* != 0).elems + @a;
}

say candy(@*ARGS);

# run as <script> rank1 rank2 ..
