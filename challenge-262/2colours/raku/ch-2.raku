#!/usr/bin/env raku

my token integer { 0 | '-'? <[1..9]> <[0..9]>* }
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/;

sub MAIN(
  $ints, Int $k
) {
    die 'Please provide valid input for @ints' unless $ints.subst(/\s/, '', :g) ~~ IntList;
    my Int() @ints = $<integer>;
    @ints.kv.map(-> $index, $value {
        my $needed-factor = $k div ($k gcd $index);
        my $next-valid = ceiling(($index + 1) / $needed-factor) * $needed-factor;
        @ints[$next-valid, $next-valid + $needed-factor ...^ @ints.elems].grep($value).elems
    }).sum.say;
}