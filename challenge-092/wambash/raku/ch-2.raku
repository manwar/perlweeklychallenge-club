#!/usr/bin/env raku

proto ii-next ( Capture $c?, :@in = Empty, :$n, :@out = Empty, Bool :$end = False ) {*};

multi ii-next ( :$n, :@in, :@out  where { $n.max < @in.head.min }  ) {
     \( out => (|@out, $n, |@in ), end => True )
}

multi ii-next ( :$n, :@in, :@out  where { @in.head.max < $n.min }  ) {
    \( out => (|@out, @in.head ), :$n, in => @in.skip )
}

multi ii-next ( :$n, :@in, :@out ) {
    \( :@out, n => (@in.head minmax $n), in => @in.skip )
}

multi ii-next ( $c, ) {
    samewith |$c
}

multi insert-interval ( :$n, :@in ) {
    \(:$n,:@in), &ii-next ... *.<end>
    andthen .tail.<out>
}

#| 5 8   1 2  3 7  8 10
multi MAIN ( *@m ) {
    @m
    andthen .map: *.Int
    andthen .map: -> $from, $to { $from .. $to }\
    andthen .cache
    andthen insert-interval n => .head, in => .skip
    andthen .map: *.bounds
    andthen .put
}

multi MAIN (Bool :$test!) {
    use Test;

    is-deeply \(n => 1..2, in => (3..4, 5..8), ).&ii-next.<out>,                   (1..2, 3..4, 5..8);
    is-deeply \(n => 3..4, in => (1..2, 5..8), ).&ii-next.&ii-next.<out>,          (1..2, 3..4, 5..8);
    is-deeply \(n => 5..8, in => (1..2, 3..4), ).&ii-next.&ii-next.&ii-next.<out>, (1..2, 3..4, 5..8);

    my $c = \( n => 5..8, in => (1..2, 3..7, 8..10) );
    is-deeply $c.&ii-next.<in>,                              (3..7, 8..10);
    is-deeply $c.&ii-next.&ii-next.<n>,                      3..8;
    is-deeply $c.&ii-next.&ii-next.&ii-next.<n>,             3..10;
    is-deeply $c.&ii-next.&ii-next.&ii-next.&ii-next.<out>,  (1..2, 3..10);
    is-deeply $c.&ii-next.&ii-next.&ii-next.&ii-next.<end>,  True;

    is-deeply insert-interval(|$c),                                   (1..2, 3..10);
    is-deeply insert-interval(n =>  2..6 , in => (1..4, 8..10)),      (1..6, 8..10);
    is-deeply insert-interval(n => 10..11, in => (1..5, 7..9 )),      (1..5, 7..9, 10..11);

    done-testing;
}
