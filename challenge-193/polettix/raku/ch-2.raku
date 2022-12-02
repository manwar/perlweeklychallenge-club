#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   @args = <adc wzy abc> unless @args;
   my %track;
   for @args -> $string {
      my $fp = fingerprint($string);
      if %track.elems == 0 { %track{$fp} = $string }
      elsif %track.elems == 1 {
         if %track{$fp}:exists        { %track{$fp} = '' }
         elsif %track.values[0].chars { %track{$fp} = $string }
         else                         { $string.put; return 0 }
      }
      else {
         %track{$fp}:delete;
         put %track.values[0];
         return 0;
      }
   }
   say fingerprint(@args[0]);
}

sub fingerprint ($string) {
   my $reference = $string.substr(0, 1).ord;
   return $string.comb.map({$_.ord - $reference}).join(' ');
}
