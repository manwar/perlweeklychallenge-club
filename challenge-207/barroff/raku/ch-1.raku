#!/usr/bin/env raku

use v6.d;

sub keyboard-word(Str $word --> Bool) {
    my $row1 = /:i <[qwertyuiop]> /;
    my $row2 = /:i <[asdfghjkl]> /;
    my $row3 = /:i <[zxcvbnm]> /;
    $word ~~ /^ [<$row1>+ | <$row2>+ | <$row3>+] $ / ?? True !! False;
}

sub keyboard-word-list(Str @words --> Array[Str]) {
    my Str @kwords = grep(&keyboard-word, @words);
    return @kwords
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is keyboard-word-list(Array[Str].new(["Hello","Alaska","Dad","Peace"])), ("Alaska", "Dad"), 'works for ("Hello","Alaska","Dad","Peace")';
    is keyboard-word-list(Array[Str].new(["OMG","Bye"])), (), 'works for ("OMG","Bye")';
}

#| Take user provided list like: Hello how are you asdf
multi sub MAIN(*@elements where @elements.elems ≥ 1 && all(@elements) ~~ /^<[a..zA..Z]>+$/) {
    my Str @str-elements = @elements;
    say keyboard-word-list(@str-elements);
}
