#!/usr/bin/env raku

use v6.*;
my token unsigned-integer { 0 | <[1..9]><[0..9]>* };
my token integer { '-'? <unsigned-integer> };
subset IntList of Str where /^ '(' <integer>* % ',' ')' $/;


sub MAIN(Str $array) {
  die 'Please supply a valid list of integers.' unless $array.subst(/\s/, '', :g) ~~ IntList;
  my Int() @array = $<integer>;
  my $streak = 0;
  my $output is default(0) = do for @array {
    $streak = $_ %% 2 ?? 0 !! $streak + 1;
    last 1 if $streak == 3; 
  }.head;
  say $output;
}

