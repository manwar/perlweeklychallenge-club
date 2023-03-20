#!/bin/env raku

sub USAGE() {
    print qq:to/END/;
    examples:
        $*PROGRAM-NAME 100
        $*PROGRAM-NAME 1110
    END
}

unit sub MAIN(Str:D $s);

grammar SBC {
    token TOP       { <Character>* }
    token Character { '0' || '10' || '11' }
}

class SBC-Actions {
    state %chars = <0 10 11> Z=> <a b c>;

    method TOP($/)       { make $<Character>».made.join }
    method Character($/) { make %chars{$/.Str} }
}

put +so SBC.parse($s, :actions(SBC-Actions)).made ~~ /a$/;
