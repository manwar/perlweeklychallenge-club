#!/usr/bin/env raku

#|(Given a list of number print all permutations where each pair in the list
where the sum of the pair is a perfect square
)
multi sub MAIN( *@values where @values.all ~~ Int() ) {
    all-perfect(@values).map(*.join(',')).join("\n").say;
}

multi sub MAIN('TEST') is hidden-from-USAGE {
    use Test;
    ok perfect( 25 );
    ok ! perfect( 24 );
    ok perfect-list((1,8,17));
    is all-perfect((1,17,8)), ( (1,8,17), (17,8,1) );
    is all-perfect((2,2,2)), ( (2,2,2) );
    done-testing;
}

sub all-perfect( @list ) {
    @list.permutations.unique(:as(-> @a {@a.join(',')})).grep( -> @a { perfect-list(@a) } );
}

sub perfect-list( @list ) {
    [&] @list.rotor(2 => -1).map(-> ($a,$b) {perfect( $a+$b )});
}

sub perfect( Int $v ) {
    $v.sqrt.Int() ~~ $v.sqrt;
}
