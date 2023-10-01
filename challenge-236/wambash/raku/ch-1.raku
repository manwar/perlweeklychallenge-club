#!/usr/bin/env raku

multi exact-change-step ( $ (:%changes, :$bill ) ) {
    %changes
    andthen .sort
    andthen .first: { .key ≤ $bill }, :end
    andthen \(changes => %changes ∖ .key, bill => $bill - .key)
    orelse Nil
}

multi exact-change-producer ( %changes, $bill ) {
    \(:%changes, :bill($bill - 5)), *.&exact-change-step ...^ !*.defined #*.<changes>.total == 0
    andthen .first: *.<bill> == 0
    andthen .<changes> (+) $bill
    orelse  Nil
}

multi exact-change-producer ( Nil, $ ) {
    Nil
}

sub exact-change (+bills) {
    produce &exact-change-producer, bag(), |bills
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply exact-change-step(\(changes => bag(20,10,10,5,5), :15bill)), \(changes => bag(20,10,5,5),:5bill);
    is-deeply exact-change-step(\(changes => bag(20,10,5,5), :5bill)), \(changes => bag(20,10,5),:0bill);
    is-deeply exact-change-step(\(changes => bag(), :5bill)), Nil;
    is-deeply exact-change-producer( bag(20,10,10,5,5),  20), bag(20,20,10,5);
    is-deeply exact-change-producer( bag(), 20), Nil;
    is-deeply exact-change(5,5,5,10,20), bag(5,20);
    is-deeply exact-change(5,5,10,10,20),Nil;
    is-deeply exact-change(10,10,20),Nil;
    is-deeply exact-change(5,5,5,20),bag(20);
    is-deeply exact-change(5,5,10,5,5,10,20,10), bag(20,10,10);
    done-testing;
}

multi MAIN (*@bills) {
    say ?exact-change @bills
}
