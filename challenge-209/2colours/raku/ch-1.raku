#!/usr/bin/env raku


my token bit { <[01]> };
subset BitList of Str where /^ '(' <bit>* % ',' ')' $/;

sub MAIN(Str $bits) {
  die 'Please supply a valid list of bits.' unless $bits.subst(/\s/, '', :g) ~~ BitList;
  my Str() @bits = $<bit>;
  die 'The last bit must be zero!' unless @bits[*-1] == 0;
  my $bit-string = @bits.join;
  $bit-string
    .trans: <0 10 11> => <a b c> andthen
    .substr(*-1) eq 'a' andthen
    .Int
    .say;
}
