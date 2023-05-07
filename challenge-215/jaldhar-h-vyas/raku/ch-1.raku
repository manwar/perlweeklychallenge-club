#!/usr/bin/raku

sub MAIN(
    *@words
) {
    my $removals = 0;

    for @words -> $word {
        my $sorted = $word.comb.sort.join;
        if $word ne $sorted {
            $removals++;
        }
    }

    say $removals;
}