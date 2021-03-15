#!/usr/bin/env raku

sub MAIN( $N = slurp.Str.chomp ) {
   sub ($N){for ^$N.chars ->$i { return 0 if $N.substr($i, 1) !~~ $N.substr(($N.chars -$i -1), 1) };1}($N).say
}
