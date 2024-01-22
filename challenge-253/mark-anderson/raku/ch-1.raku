#!/usr/bin/env raku
use Test;

is-deeply split-strings(<one.two.three four.five six>, '.'),
                        <one two three four five six>;

is-deeply split-strings(<$perl$$ $$raku$>, '$'),
                        <perl raku>;

sub split-strings(@a, $separator)
{
    flat @a>>.split($separator, :skip-empty)
}
