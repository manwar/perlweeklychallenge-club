#!/usr/bin/raku

sub MAIN(
    $string,
    *@indices
) {
    my @letters = $string.comb;
    my @result;

    for @letters Z @indices -> ($letter, $index) {
        @result[$index] = $letter;
    }

    @result.join.say;
}