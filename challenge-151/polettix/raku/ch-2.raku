#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put rob-the-house(@args) }

sub rob-the-house (@list) {
   multi sub rth ($index where * > @list.end) { return 0 }
   my @cache;
   multi sub rth ($index) {
      @cache[$index] //= @list[$index] + (2, 3).map({rth($index + $_)}).max;
   }
   return rth(0);
}
