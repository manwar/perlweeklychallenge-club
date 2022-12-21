#!/usr/bin/env raku

my token integer { 0 | '-'? <[1..9]> <[0..9]>* }
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/; # The task didn't specify what a "list of numbers" should be - treating it as a list of integers

sub MAIN(
  $list #= list of integer numbers
) {
  die 'Please provide valid input for @list' unless $list.subst(/\s/, '', :g) ~~ IntList;
  my Int() @list = $<integer>;
  @list.grep(* %% 2).Bag andthen
    .so ?? .max({ .value, - .key }).key !! -1 andthen
    .say;

}
