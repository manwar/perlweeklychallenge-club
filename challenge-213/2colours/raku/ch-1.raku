#!/usr/bin/env raku


my token positive-integer { <[1..9]><[0..9]>* };
subset PosIntList of Str where /^ '(' <positive-integer>* % ',' ')' $/;

sub MAIN(Str $list) {
  die 'Please supply a valid list of positive integers.' unless $list.subst(/\s/, '', :g) ~~ PosIntList;
  my Int() @list = $<positive-integer>;
  @list
    .sort: {$_ mod 2, $_}andthen
    .join: ',' andthen
    "($_)" andthen
    .say
}
