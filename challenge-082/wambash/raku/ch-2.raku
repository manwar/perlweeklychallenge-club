#!/usr/bin/env raku

multi step ( ( :@what where :!elems, :@from where :!elems ) ) {
    True
}

multi step ( (:@what, :@from ) ) {
    @from.first: { .head eqv @what.head}, :k
    andthen \(
        what => @what.skip,
        from => (
            |@from[0 ..^ $_],
            @from[$_].skip.cache || Empty,
            |@from[$_ ^.. *]
        ).pick(*),
    )
    orelse False
}

multi interleave ( :@what, :@from ) {
    \( :@what, :@from )
    andthen $_, *.&step ... Bool
}

multi interleave ( Str :$what, :@from ) {
    samewith(
        what => $what.comb,
        from => @from.map: *.comb.cache,
    ).tail
}


multi MAIN ( $what, +@from ) {
    say interleave(:$what, :@from)
}

multi MAIN (Bool :$test!) {
    use Test;
    is-deeply interleave( :what(1,2,2,3), :from((1,2),(2,3)) ).[*-3], \( :what((3).Seq),:from(((3,),).Seq) );
    ok interleave( :what<XXY>, :from<XY X> );
    ok interleave( :what<XXXXZY>, :from<XXY XXZ> );
    nok interleave( :what<XXY>, :from<YX X> );
    done-testing;
}
