#!/usr/bin/env raku

my @*keyboard := <qwertyuiop asdfghjkl zxcvbnm>».comb;

sub keyboard-word (+@words,:@keyboard=@*keyboard) {
    my @keyboard-rows = @keyboard.map: { rx:i/^ @^row + $/ };
    my &keyboard-regex = rx/@keyboard-rows/;
    @words.grep: *.contains:  &keyboard-regex #or @keyboard-rows.any;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply keyboard-word(<Hello Alaska Dad Peace>),<Alaska Dad>;
    is-deeply keyboard-word(<OMG Bye>), $();
    done-testing;
}

multi MAIN (*@words,:$keyboard=@*keyboard) {
    say keyboard-word @words, :$keyboard
}
