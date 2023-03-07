#!/usr/bin/env raku


constant @rows = <qwertyuiop asdfghjkl zxcvbnm>;
subset StrList of Str where /^ '(' ['"' $<str-content>=[.*?]  '"']* % ',' ')' $/;

sub MAIN(Str $input) {
  die 'Please provide a valid list of double-quoted (constant) strings.' unless $input.subst(/\s/, '', :g) ~~ StrList;
  my Str() @words = $<str-content>;
  @words
    .grep: *.lc.comb.Set (<=) @rows.any.comb.Set andthen
    .say
}