multi sub task2 (      0, @ns --> Int ) {
    return 0 if 0 ∉ @ns;

    warn "Infinite loop avoided; no doubling of startpoint (0) will ever fall outside of the given @ns: ({@ns})";
    return Nil;
}
multi sub task2 ( $start, @ns --> Int ) {
    my @doublings = $start,  * × 2  …  Inf;

    return @doublings.first: * ∉ @ns;
}


# If the same @ns needs to be called with lots many different $start,
# we could pre-calculate the chain of results to (possibly) improve performance.
sub task2-many ( @ns, @lots-of-starts ) {
    my %cache;
    for @ns.sort(-*) -> $n {
        %cache{$n} = %cache{$n * 2}
                        // ($n * 2);
    }

    return @lots-of-starts.map: { %cache{$_} // $_ };
}


use Test; plan -1 + 2 * +constant @tests =
    ( 24, 3, (5,3,6,1,12) ),
    (  8, 1, (1,2,4,3)    ),
    (  2, 2, (5,6,7)      ),

    (  0, 0, (5,6,7)      ),
    (Nil, 0, (5,6,7,0)    ),
;
for @tests -> ( $expected, $start, @ns ) {
    is task2($start, @ns), $expected;

    # task2-many does not special-case `$start==0 && 0 ∈ @ns`, and so would fail my last testcase.
    next if !$expected.defined;

    is task2-many( @ns, [$start] )[0], $expected;
}
