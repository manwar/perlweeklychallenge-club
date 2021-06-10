#!/usr/bin/env raku

## see usage:
## pk@pkx:~/stuff/.../challenge-106/pkmnx/raku$ time ./ch-1.raku 2 9 3 5
## 4
##
## real    0m0.190s
## ...

sub MAIN( *@N where all(@N) ~~ Int ) {

  die "No input." if @N.elems < 1;
  0.say && exit if @N.elems == 1;

  @N = @N.sort;

  ( 0..^@N.elems -1 ).map( -> $i {
     my ($a,$b) = ( @N[$i], @N[$i +1] );
     $b - $a;
  }).max.say;

}
