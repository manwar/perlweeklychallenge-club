#!/usr/bin/env raku
use Test;

is-deeply split-strings(<one.two.three four.five six>, '.'),
                        <one two three four five six>;

is-deeply split-strings(<$perl$$ $$raku$>, '$'),
                        <perl raku>;

sub split-strings(@words, $separator)
{
    flat @words>>.split($separator, :skip-empty)
}
