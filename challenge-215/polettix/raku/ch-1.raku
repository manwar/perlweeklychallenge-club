#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put count-odd-one-out(@args) }

sub count-odd-one-out (@words) {
   my $i = 0;
   return sum gather for ^@words {
      if @words[$i] le @words[$_] { $i = $_ }
      else                        { take 1  }
   }
}
