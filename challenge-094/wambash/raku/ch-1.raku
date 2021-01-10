#!/usr/bin/env raku

sub group-anagrams ( +@s ) {
    @s
    andthen .classify:  *.comb.Bag
}

multi MAIN (Bool :$test!) {
    use Test;
    is group-anagrams(<x>).values, <x>;
    is-deeply group-anagrams(<opt bat saw tab pot top was>).values.sort,(<opt pot top>, <saw was>, <bat tab>).map(*.Array).sort;
    done-testing
}

multi MAIN ( *@s ) {
    say group-anagrams(@s).values
}
