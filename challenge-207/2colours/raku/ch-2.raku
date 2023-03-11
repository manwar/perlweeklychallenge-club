#!/usr/bin/env raku


my token unsigned-integer { 0 | <[1..9]><[0..9]>* };
my token integer { '-'? <unsigned-integer> };
# negative citation counts don't really make sense but that's what the task said /s
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/;

sub MAIN(Str $array) {
  die 'Please supply a valid list of integers.' unless $array.subst(/\s/, '', :g) ~~ IntList;
  my Int() @array = $<integer>;
  @array
    .sort
    .reverse
    .map: {
      last unless $_ >= ++$;
      1 
    } andthen
    .sum
    .say;
}
