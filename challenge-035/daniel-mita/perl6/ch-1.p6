#!/usr/bin/env perl6
use v6.d;
use lib $?FILE.IO.dirname;
use Morse;

# My intention to take &encode directly from Morse and
# use it as MAIN here. This does what I intended, but
# I'm unsure if it was the best way to go about it.

sub MAIN (
  |c where * ~~ &encode.signature,
  --> Nil
) {
  encode(||c).say;
}

sub GENERATE-USAGE(|) {
  RUN-MAIN(&encode, Nil);
}
