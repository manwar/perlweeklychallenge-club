#!/usr/bin/env raku

use v6.d;

sub find-words(@list, Str $char where $char.chars == 1 --> Seq) {
    grep({ @list[$_] ~~ / "$char" / }, 0..@list.elems - 1);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is find-words(["the", "weekly", "challenge"], "e"), [0, 1, 2],
        'works for ["the", "weekly", "challenge"] and "e"';
    is find-words(["perl", "raku", "python"], "p"), [0, 2],
        'works for ["perl", "raku", "python"] and "p"';
    is find-words(["abc", "def", "bbb", "bcd"], "b"), [0, 2, 3],
        'works for ["abc", "def", "bbb", "bcd"] and "b"';
}

#| Take user provided words like e the weekly challenge
multi sub MAIN(Str $char where $char.chars == 1, *@list) {
    say find-words(@list, $char);
}
