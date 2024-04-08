#!/usr/bin/raku

sub MAIN(
    $k,
    *@ints
) {
    my @sorted = @ints.sort;
    say q{(}, @sorted.keys.grep({ @sorted[$_] == $k}).join(q{, }), q{)};
}