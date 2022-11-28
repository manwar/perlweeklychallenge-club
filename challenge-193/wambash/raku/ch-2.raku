#!/usr/bin/env raku
#
my sub agg( $ ( :$average, :to-next($from-previous), :$moves, ), $n ) {
    my $to-next = $from-previous + $n - $average;

    \(
        :$average,
        :$to-next,
        moves   => $moves + $to-next.abs ,
    )
}

sub equal-distribution (+@list) {
    return Nil unless @list.sum %% @list.elems;

    my $average = @list.sum div @list.elems;

    @list
    andthen \(:$average, :0moves, :0to-next,), .Slip
    andthen .reduce: &agg
    andthen .<moves>
}

multi MAIN (Bool :test($)!) {
    use Test;
    is equal-distribution(1,0,5), 4;
    is equal-distribution(1,2,3), 2;
    is equal-distribution(1,2,3), 2;
    is equal-distribution(0,2,0), Nil;
    is equal-distribution(0,3,0), 2;
    is equal-distribution(1..5), 10;
    done-testing;
}

multi MAIN (*@list) {
    say equal-distribution(@list) // -1
}
