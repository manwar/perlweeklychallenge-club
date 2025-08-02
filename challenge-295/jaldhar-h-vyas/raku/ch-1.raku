#!/usr/bin/raku

sub MAIN(
    *@words
) {
    my $str = @words.shift;
    for @words -> $word {
        $str ~~ s:g/$word//;
    }

    say $str.chars < 1;
}
