#!/bin/env raku

unit sub MAIN(*@a);

my @Can = @a.sort({ $^b cmp $^a }).combinations(3).grep({
    .[0] + .[1] > .[2] and
    .[1] + .[2] > .[0] and
    .[2] + .[0] > .[1]
});

if @Can.elems == 0 {
    put '()';
} else {
    put '(', @Can.grep({ .sum == @Can».sum.max }).first.join(', '), ')';
}
