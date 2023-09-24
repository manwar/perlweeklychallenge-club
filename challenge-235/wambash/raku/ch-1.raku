#!/usr/bin/env raku

sub remove-one (+@ints) {
    ^@ints
    andthen .first: { [<] @ints[0..$_-1, $_+1..*].flat }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is remove-one(0,2,9,4,6),2;
    is remove-one(5,1,3,2), Nil;
    is remove-one(2,2,3), 0;
    done-testing;
}

multi MAIN (*@ints) {
    say remove-one(@ints) !=== Nil
}
