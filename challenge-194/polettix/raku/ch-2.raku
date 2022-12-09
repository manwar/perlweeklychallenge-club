#!/usr/bin/env raku
use v6;
sub MAIN (*@ARGV) {
   @ARGV = < abbc xyzyyxz xzxz > unless @ARGV;
   put "{frequency-equalizer($_)} -> $_" for @ARGV;
}

sub frequency-equalizer ($string) {
   my (%first_counter, %second_counter);
   ++%first_counter{$string.substr($_, 1)} for ^$string.chars;
   ++%second_counter{$_} for %first_counter.values;
   return 0 if %second_counter.elems != 2;
   my ($k1, $v1, $k2, $v2) = %second_counter.kv;
   ($k1, $v1, $k2, $v2) = $k2, $v2, $k1, $v1 if $k1 > $k2;
   return 1 if $v2 == 1 && $k2 - $k1 == 1;
   return 0;
}
