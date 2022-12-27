#!/usr/bin/env raku

sub pattern132 (+@list) {
    @list
    andthen .combinations: 3
    andthen .first: -> ($i, $j, $k) { $i < $k < $j }\                       
}

multi MAIN (Bool :test($)!) {
    use Test;
    is pattern132(3,1,4,2),(1,4,2);
    is pattern132(1,2,3,4), Nil;
    is pattern132(1, 3, 2, 4, 6, 5), (1,3,2);
    is pattern132(1, 3, 4, 2), (1,3,2);
    done-testing;
}

multi MAIN (*@list) {
    say pattern132 @list
}
