#!/usr/bin/env raku
use v6;
sub MAIN ($string) { put is-additive-number($string) }

multi sub is-additive-number ($string --> Bool) {
   my $len = $string.chars;
   return False unless $len > 2;
   for 1 .. ($len - 2) -> $l1 {
      for 1 .. ($len - $l1 - 1) -> $l2 {
         return True if is-additive-number($string, $l1, $l2);
      }
   }
   return False;
}

multi sub is-additive-number ($string, $l1, $l2 --> Bool) {
   my $ls = $string.chars;
   my @v = $string.substr(0, $l1), $string.substr($l1, $l2);
   my $i = $l1 + $l2;
   while $i < $ls {
      my $v = @v.shift.Int;
      $v += @v[0].Int;
      $v = $v.Str;
      my $lv = $v.chars;
      return False if $lv > $ls - $i;
      return False if $string.substr($i, $lv) ne $v;
      @v.push: $v;
      $i += $lv;
   }
   return True;
}
