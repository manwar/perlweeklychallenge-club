#!/usr/bin/env raku

sub list-methods ( ::T ) {
    T.^methods.map: *.name
}

sub MAIN (Bool :$test!) {
    use Test;
    
    my $class = class :: {
        method new {}
        method add {}
        method mul {}
        method div {}
    }

    my $role = role :: {
        method new {...}
        method add {...}
        method mul {...}
        method div {...}
    }

    is list-methods($class), <new add mul div BUILDALL>;
    is list-methods($role ), <new add mul div>;
    done-testing;
}
