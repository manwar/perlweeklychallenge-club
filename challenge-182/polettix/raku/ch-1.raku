#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   @args = 5, 2, 9, 1, 7, 6 unless @args;
   put max-index(@args);
}

sub max-index (@args) {
   (0 ..^ @args).sort(
      {
         @args[$^a] <=> @args[$^b] # sort by value, but if equal...
         || $^b <=> $a             # just be anti-stable
      }
   )[*-1] # then just take the last element
}
