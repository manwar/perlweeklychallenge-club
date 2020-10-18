#!/usr/bin/env raku

multi iter ( ( (),Empty ) ) {
    True
}

multi iter ( (@c,+@a) ) {
    @a.first: { .head eqv @c.head}, :k
    andthen \(@c.skip, |@a[0..^ $_], @a[$_].skip.cache||Empty, |@a[$_ ^.. *])
    orelse False
}

\((1,2,2,2,3),(1,2),(2,2,3)), *.&iter ... Bool
andthen .say;

sub interleave-string (@c, +@a) {
    ...
}
