#!/usr/bin/env perl6
use v6.d;
use lib $?FILE.IO.dirname;
use Morse;

RUN-MAIN( &decode, Nil );

sub MAIN ( |c --> Nil ) {
  decode(||c).say;
}
