#!/usr/bin/env raku

sub odd-number (*@inputs) {
   my %is-odd;
   for @inputs -> $element {
      if %is-odd{$element} { %is-odd{$element}:delete }
      else                 { %is-odd{$element} = 1    }
   }
   return %is-odd.keys;
}

sub MAIN (*@inputs) {
   @inputs = 2, 5, 4, 4, 5, 5, 2 unless @inputs;
   put odd-number(@inputs);
}
