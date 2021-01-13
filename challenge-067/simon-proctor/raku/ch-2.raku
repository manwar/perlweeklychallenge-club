#!/usr/bin/env raku

#| Given a string of numbers print all the possible words this could spell on a phone keypad
sub MAIN (
    Str $phone where /^ \d+ $/ #= Phone number string
) {
    my %letters = (
        1 => <_ , @>,
        2 => <a b c>,
        3 => <d e f>,
        4 => <g h i>,
        5 => <j k l>,
        6 => <m n o>,
        7 => <p q r s>,
        8 => <t u v>,
        9 => <w x y z>,
        0 => []
    );

    .say for [X~] %letters{$phone.comb};
}
