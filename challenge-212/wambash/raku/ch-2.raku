#!/usr/bin/env raku
proto rearrange-group-iter ((Bag :$bag, :@acc, :$size )) {*}

multi rearrange-group-iter ((:$bag,:@acc,:$size where { $bag.total !%% $size } ) ) {
    \( acc => Nil, bag => bag() )
}

multi rearrange-group-iter (( Bag:D :$bag,:@acc,:$size))  {
    $bag.min.key .. *
    andthen .head: $size
    andthen .cache
    andthen \( bag => ( $bag ∖ $_ ), acc => (|@acc, $_), :$size )
}

sub rearrange-group (+@list, :$size) {
    @list.Bag
    andthen \( bag => $_, acc => (), :$size ), &rearrange-group-iter ... *.<bag>.total == 0
    andthen .tail.<acc>
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply rearrange-group((1,2,3,5,1,2,7,6,3),:3size), ((1,2,3), (1,2,3), (5,6,7));
    is-deeply rearrange-group((1,2,3),:2size), Nil;
    is-deeply rearrange-group(1,2,4,3,5,3,:3size), ((1,2,3),(3,4,5));
    is-deeply rearrange-group(1,5,2,6,4,7,:3size), Nil;
    done-testing;
}

multi MAIN (*@list,:$size!) {
    say rearrange-group @list».Int,:$size
}
