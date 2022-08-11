#!/usr/bin/env raku
use v6;

class CyclopFactory { ... }

sub MAIN (Int $n = 20) {
   my $it = CyclopFactory.new();
   $it.get.put for 1 .. $n;
}

class CyclopFactory {
   has $!n is built = 0;
   method get {
      loop {
         $!n = ($!n + 1).Str;
         $!n ~~ tr/0/1/;
         $!n = ($0 + 1) ~ $1 if $!n ~~ /^ (<[ 2 4 6 8 ]>) (.*) /;
         my $candidate = $!n ~ '0' ~ $!n.flip;
         return $candidate if $candidate.is-prime;
      }
   }
}
