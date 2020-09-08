#!/usr/bin/env raku

constant @fib := 1,2 , * + * ... *;

multi iter ( Capture $c ( :$sum, :@pos, :@used ) ) {
    \( sum => $sum + @pos.head, pos => @pos.skip, used => (|@used, @pos.head) ),
    \( |$c, pos => @pos.skip)
};

multi iter ( Seq(Any) $a  ) {
    $a.map: |*.&iter
}


sub fib-sum ( $sum ) {
    state @fib-sum = \( :0sum, pos => @fib ),  *.&iter.cache ... *;
    my $stop-index = @fib.first: * > $sum, :k;

    @fib-sum
    andthen .[$stop-index]
    andthen .grep: { .<sum> == $sum }
}

sub MAIN ( :$test!, :$log ) {
    use Test;

    my $wi = &iter.wrap: {
        say .<sum>," ",.<used>, " ",.<pos>.cache.head when Capture;
        callsame
    } if $log;

    is-deeply fib-sum(9).map( *.<used>), ((1,3,5),(1,8)),;
    is-deeply fib-sum(6).map( *.<used>), ((1,2,3),(1,5)),;

    $wi.restore if $log;

    done-testing()
}
