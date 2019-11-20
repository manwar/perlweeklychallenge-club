#!/usr/bin/env perl6
use v6.d;
use lib $?FILE.IO.dirname;
use Morse;

our &MAIN = &say ∘ &encode;
RUN-MAIN( &encode, Nil );
