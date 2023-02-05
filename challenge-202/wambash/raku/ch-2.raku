#!/usr/bin/env raku

sub tail-same (+@list) {
    my @rev-list = @list.reverse;
    @rev-list.toggle: * == @rev-list[0]
}

sub valley-producer (Capture ($direct, :@acc, :valley($)), $element ) {
    my $new-direct := @acc.tail <=> $element || $direct;

    $direct < $new-direct
    ?? \( More, :acc(|tail-same(@acc),$element),:valley(@acc))
    !! \( $new-direct, :acc(|@acc,$element), :valley(Empty) )
}



sub valleys (+@list) {
    |@list, -∞
    andthen \(Less,:acc(.head,),:valley(Empty)), |.skip
    andthen .produce: &valley-producer
    andthen .map: *<valley>
}

sub widest-valley (+@list) {
    valleys @list
    andthen .max: *.elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is tail-same(1,3,3,1), 1;
    is tail-same(1,3,3,3),(3,3,3);
    is-deeply valley-producer(\(Less,:acc(2,1,3,)),1), \(More, :acc(3,1),:valley(2,1,3));
    is-deeply valley-producer(\(Less,:acc(2,1,3,)),4), \(Less, :acc(2,1,3,4),:valley(Empty));
    is-deeply valley-producer(\(Less,:acc(1,2,3,3)),1), \(More, :acc(3,3,1),:valley(1,2,3,3));
    is-deeply valleys(1, 5, 5, 2, 8, 1, 3, 2,2, 6, 1), ((1,5,5),(5,5,2,8),(8,1,3),(3,2,2,6));
    is-deeply widest-valley(1, 5, 5, 2, 8), (5,5,2,8);
    is widest-valley(2, 6, 8, 5), (2,6,8);
    is widest-valley(9, 8, 13, 13, 2, 2, 15, 17), (13,13,2,2,15,17);
    is widest-valley(2, 1, 2, 1, 3), (2,1,2);
    is widest-valley(1, 3, 3, 2, 1, 2, 3, 3, 2), (3,3,2,1,2,3,3);
    done-testing;
}

multi MAIN (*@list) {
    put widest-valley @list
}
