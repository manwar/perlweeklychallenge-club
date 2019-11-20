#!/usr/bin/env perl6
use v6.d;
use lib $?FILE.IO.dirname;
use Morse;

RUN-MAIN( &encode, Nil );

sub MAIN ( |c --> Nil ) {
  encode(||c).say;
}
