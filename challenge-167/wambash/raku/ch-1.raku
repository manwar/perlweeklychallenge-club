#!/usr/bin/env raku

multi is-circular-prime ($n --> Bool) {
    samewith $n.comb
}

multi is-circular-prime (@n --> Bool) {
   @n, *.rotate.cache ... *
   andthen .head: @n.elems
   andthen .map: *.join
   andthen .all.is-prime.so
}

multi expand ( +@a (1, *@) ) { slip |@a X,  1,3,7,9   }
multi expand ( +@a (3, *@) ) { slip |@a X,    3,7,9   }
multi expand ( +@a (7, *@) ) { slip |@a X,      7,9   }

multi find-uniq-circular (@k where  .head ~~ Int|Int(Str) ) {
    samewith @k.map: *.comb
}

multi find-uniq-circular (@n) {
    @n
    andthen .grep: {@^p.head == @^p.min }\
    andthen .grep: {@^p.head !== @^p.tail or  [==] @^p }\
    andthen .grep: &is-circular-prime
    andthen .map:  *.join
}


multi MAIN (Bool :test($)!) {
    use Test;
    is is-circular-prime(113.comb   ), True;
    is is-circular-prime(133.comb   ), False;
    is is-circular-prime(193939), True;
    is is-circular-prime(1193.comb  ), True;
    is find-uniq-circular(['1193',  11, 1 x 19]), <1193 11 1111111111111111111>;
    is find-uniq-circular([1193, 1931, 1192, 9311,3119]), <1193> ;
    done-testing;
}


multi MAIN ( :$n=6, :$s=2 ) {
    (1,3,7), { .map: &expand } ... *
    andthen .skip: $s
    andthen .map: &find-uniq-circular
    andthen .head: $n - $s
    andthen .put
}
