#!/usr/bin/env raku

sub jort-sort (+@n) {
    [before] @n
}

multi MAIN (Bool :test($)!){
    use Test;
    is jort-sort(1,2,3,4,5), True;
    is jort-sort(1,3,2,4,5), False;
    is jort-sort(<a b s z>), True;
    is jort-sort(<a b s c z>), False;
    done-testing;
}

multi MAIN (*@n) {
    say +jort-sort @n
}
