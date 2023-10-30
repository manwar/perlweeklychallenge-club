#!/usr/bin/env raku

sub array-loops (+@ints) {
    my %hints := @ints.pairs.Map;

    @ints.map(*.Set).Set, { set $_.keys.map: { [(|)] $_, %hints{|.keys }  } } ...^ * eqv *
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply(
        array-loops(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10),
        set(set(4,15,1,6,13,5,0),set(3,8,7,18,9,16,12,17,2), set(14,11,19,10)),
    );
    is-deeply(
        array-loops(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19),
        set(set(0),set(1), set(13,9,14,17,18,15,5,8,2), set(7,11,4,6,10,16,3),set(12),set(19)),
    );
    is-deeply(
        array-loops(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17),
        set(set(0..19),),
    );
    is array-loops(0..19).elems,20;
    is array-loops(|(1..19),0).elems,1;
    done-testing;
}

multi MAIN (+@ints) {
    say +array-loops @ints
}
