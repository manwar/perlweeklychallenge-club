#!/usr/bin/env raku

my @seq = 'A', {++$_} ... *;

multi sub MAIN(Int :$num) {
        say @seq[$num - 1];
}

multi sub MAIN(Str :$col) {
        say @seq.first($col, :k) + 1;
}
