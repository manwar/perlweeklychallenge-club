#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { say fun-sort(@args ?? @args !! [1 .. 6]) }

sub fun-sort (@input) {
   my (@even, @odd);
   for @input -> $v {
      if $v %% 2 { @even.push: $v.Int }
      else       { @odd.push: $v.Int  }
   }
   return (@even.sort, @odd.sort).flat;
}
