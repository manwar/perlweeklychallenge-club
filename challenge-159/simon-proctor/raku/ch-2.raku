#!/usr/bin/env raku

#| Given a number n print the Möbius number for it
sub MAIN( Int() \n ) {
    say Möbius(n);
}

multi sub prime-factors(1) { [] }
multi sub prime-factors(Int() $x) {
    my $p = (2..^$x).first($x %% *);
    return $p ?? [$p, |prime-factors($x div $p)] !! [$x]
}
sub square-free(Int() $x) {
    my @p = prime-factors($x);
    @p ~~ @p.unique
};
sub Möbius($x) {
    square-free($x) ??
    (
        prime-factors($x).elems %% 2 ?? 1 !! -1
    )
    !! 0;
}
