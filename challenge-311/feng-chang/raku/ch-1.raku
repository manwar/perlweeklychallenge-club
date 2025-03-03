#!/bin/env raku

unit sub MAIN(Str:D $s);

my method upper-lower(Str:D $c : --> Str:D) {
    given $c {
        when 'a'..'z' { ($c.ord + 'A'.ord - 'a'.ord).chr }
        when 'A'..'Z' { ($c.ord - 'A'.ord + 'a'.ord).chr }
        default       { $c }
    }
}

put $s.comb».&upper-lower.join;
