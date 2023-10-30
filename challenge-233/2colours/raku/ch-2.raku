#!/usr/bin/env raku

my token integer { 0 | '-'? <[1..9]> <[0..9]>* }
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/; # The task didn't specify what a "list of numbers" should be - treating it as a list of integers

sub MAIN(
  $ints #= list of integer numbers
) {
  die 'Please provide valid input for @list' unless $ints.subst(/\s/, '', :g) ~~ IntList;
  my Int() @ints = $<integer>;
  @ints.Bag.classify(*.value, as => *.key)>>.sort(-*).sort(*.key).map({ .value<> Xxx .key }).flat.list.raku.say;
}