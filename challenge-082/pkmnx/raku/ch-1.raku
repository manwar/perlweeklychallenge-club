#!/usr/bin/env rakudo

sub MAIN( Int $m = 18, Int $n = 12, $gc = $m gcd $n ) {

  die( "too many args!" ) if @*ARGS.end > 1;

  ( 1 .. $gc ).grep(-> $k { $gc %% $k } ).say;

}
