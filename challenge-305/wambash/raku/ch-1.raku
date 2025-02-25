#!/usr/bin/env raku

sub binary-prefix (+binary) {
    binary
    andthen [\~] binary
    andthen .map: { :2(.Str).is-prime }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is binary-prefix(1,0,1), (False,True,True);
    is binary-prefix(1,1,0), (False,True,False);
    is binary-prefix(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1), (
        False, True, True, False, False,
        True, False, False, False, False,
        False, False, False, False, False,
        False, False, False, False, True
    );
    done-testing;
}

multi MAIN (+binary) {
    put binary-prefix binary
}
