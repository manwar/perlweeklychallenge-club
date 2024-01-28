#!/usr/bin/env raku

sub split-string (+words, :$separator=q{ }) {
    words.map: |*.split($separator, :skip-empty )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply split-string(<one.two.three four.five six>):separator('.'), <one two three four five six>;
    is-deeply split-string(<$perl$$ $$raku$>):separator('$'),<perl raku>;
    done-testing;
}

multi MAIN (+words, :$separator=q{ }) {
    put split-string words, :$separator
}
