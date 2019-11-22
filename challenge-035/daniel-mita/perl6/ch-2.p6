#!/usr/bin/env perl6
use v6.d;
use lib $?FILE.IO.dirname;
use Morse;

proto MAIN (|) {
  {*}
  CATCH {
    when X::Morse {
      say "Error: {.message}";
      exit 1;
    }
  }
}

multi MAIN (--> Nil) { MAIN(slurp) }

multi MAIN (
  |c where * ~~ &decode.signature,
  --> Nil
) { decode(||c).say }

sub GENERATE-USAGE ( &main, |capture ) { RUN-MAIN( &decode, Nil ) }
