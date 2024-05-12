#!/usr/bin/env raku

my token integer { 0 | '-'? <[1..9]> <[0..9]>* }
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/;

sub MAIN(
    $ints
) {
    die 'Please provide valid input for @ints' unless $ints.subst(/\s/, '', :g) ~~ IntList;
    my Int() @ints = $<integer>;
    @ints.grep(* != 0).classify(*.sign).map(*.value.elems).max.say;
}