#!/usr/bin/raku

sub MAIN(
    $sentence is copy,
    *@words
) {
    for @words -> $word {
        $sentence ~~ s:g/$word\w+/$word/;
    }

    say $sentence;
}