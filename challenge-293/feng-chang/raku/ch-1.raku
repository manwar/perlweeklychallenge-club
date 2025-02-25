#!/bin/env raku

unit sub MAIN(Str:D $dom-str);

use MONKEY-SEE-NO-EVAL;

my @dominos = EVAL $dom-str;
put +@dominos.grep(-> \a { @dominos.map({ is-similar(a, $_) }).sum > 1 });

sub is-similar(@A, @B --> Bool:D) {
    @A[0] == @B[0] and @A[1] == @B[1] or
    @A[1] == @B[0] and @A[0] == @B[1]
}
