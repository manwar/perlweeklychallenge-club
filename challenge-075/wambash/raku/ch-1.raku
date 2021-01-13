use v6;

multi iter (Capture $c where *.<sum> == 0) {
    $c,
}

multi iter (Capture $c ( :@coins, :$sum where * ≥ 0, :$used = bag() ),) {
         \(|$c, sum => $sum - @coins.head, used => $used (+) @coins.head,),
         \(|$c, coins => @coins.skip,),
}


multi iter (Seq $a) {
    $a
    andthen .map: |*.&iter
    andthen .grep: *.<coins>.so
    andthen .grep: { .<sum> ≥ 0 }
}

multi coins-sum (|c where *.<sum> == 0 --> Empty) {}
multi coins-sum (|c (:$sum, :@coins) ) {
    my $deep-to-sums-are-zero = $sum/@coins.min + @coins.elems;
    (c,).Seq, *.&iter ... *
    andthen .skip($deep-to-sums-are-zero)
    andthen .head;

    #or this one, but it needs cache
    #(c,), *.&iter.cache ... *.all.<sum> == 0
    #andthen .tail
}

sub coins-sum-count ( :@coins!, :$sum! ) {
    0 xx *,
    -> @previous-seq {
        my $k=@coins[$++];
        |@previous-seq[^$k], @previous-seq[$k]+1, -> *@this-seq { @this-seq[(++$)] + @previous-seq[($k+ ++$)] } ... *
    } ... *
    andthen .[@coins.elems;$sum]
}

multi MAIN ( :$test!, :$log ) {
    use Test;

    my $wi = &iter.wrap: -> $_ {
        note .<sum>,.<coins>,.<used>.kxxv  when Capture;
        callsame()
    } if $log;

    is coins-sum( :coins(1,2,4), :6sum ).elems, 6;
    is-deeply coins-sum( :coins(1,13), :26sum ).map( *.<used> ), ( (1=>26).Bag, (13,1=>13).Bag, (13=>2).Bag );
    $wi.restore() if $log;

    is coins-sum-count( :coins(1,2,4), :6sum ), 6;
    is coins-sum-count( :coins(1,2,4,5), :120sum ), 8333;
    for ^10 {
        my @coins= (1..20).pick(3);
        my $sum = ^100 .roll;
        my $count = coins-sum-count( :@coins, :$sum );
        is coins-sum( :@coins,:$sum ).elems, $count, "elems = count = $count :{:@coins} :{:$sum}";
    }
    done-testing();
}
