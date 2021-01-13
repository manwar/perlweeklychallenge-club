#!/usr/bin/env raku

multi MAIN(Str $s where $s !~~ /<[2..9]>**2/) {
    say "Usage: $*PROGRAM-NAME [2..9]**2";
    say "Example: $*PROGRAM-NAME 3678";
}

multi MAIN(Str $s) {
    my %letters = 2 => <a b c>,
                  3 => <d e f>,
                  4 => <g h i>,
                  5 => <j k l>,
                  6 => <m n o>,
                  7 => <p q r s>,
                  8 => <t u v>,
                  9 => <w x y z>;
    
    my @arr = gather { take %letters{$_} for $s.comb }

    say ([X] @arr).map(*.join).rotor(10, :partial).join("\n");
}
