#!/usr/bin/env raku


my token unsigned-integer { 0 | <[1..9]><[0..9]>* };
my token integer { '-'? <unsigned-integer> };
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/;

sub MAIN(Str $list) {
  die 'Please supply a valid list of integers.' unless $list.subst(/\s/, '', :g) ~~ IntList;
  my Int() @list = $<integer>;
  @list
    .sort
    .rotor(2 => -1)
    .cache
    .map: {.[1] - .[0]} andthen
    .maxpairs
    .elems
    .say    
}