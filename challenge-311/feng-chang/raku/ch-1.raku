#!/bin/env raku

unit sub MAIN(Str:D $s);

my method upper-lower(Str:D $c : --> Str:D) {
    with $c {
        when 'a'..'z' { .uc }
        when 'A'..'Z' { .lc }
        default       { $c }
    }
}

put $s.comb».&upper-lower.join;
