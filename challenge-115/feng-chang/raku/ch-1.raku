#!/bin/env raku

sub MAIN(*@S) {
    for @S.permutations -> @s {
        if (^@s.elems).map({ @s[$_].substr(*-1) eq @s[($_+1) % @s.elems].substr(0,1) }).all {
            put 1;
            exit;
        }
    }

    put 0;
}
