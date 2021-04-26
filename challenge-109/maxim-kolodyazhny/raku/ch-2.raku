#!/usr/bin/env raku

multi sub MAIN ( $_  where { /\,/ } ) { samewith .split: <,> }
multi sub MAIN ( *@n  where { .unique and .all ~~ /^ \d+ $/ and .elems == 7 }) {
    @n.permutations
        .first({
                [==] .rotor( <2 -1 3 -1 3 -1>.pairup )>>.sum
            })
        .say
}

sub USAGE() {
    print qq:to/EOH/;
    Usage: {$*PROGRAM-NAME} [1,2,3,...,7] or [1 2 3 ... 7]

    Prints the answer for "Four Squares Puzzle"
EOH
}
