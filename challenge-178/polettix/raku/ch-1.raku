#!/usr/bin/env raku
use v6;

sub MAIN (Str:D() $x) { put to-m4i($x) }

sub to-m4i (Complex:D() $cx) {
   my $real = b10-to-bm($cx.re.Int, -4).comb.join('0') || 0;
   my $img  = b10-to-bm(-2 * $cx.im.Int, -4).comb.join('0');
   if $img.chars {
      my $after = $img.substr(*-1, 1);
      $img.substr-rw(*-1, 1) = '';
      $real += $img if $img.elems;
      $real ~= '.' ~ $after if $after > 0;
   }
   return $real;
}

multi sub b10-to-bm (Int:D $x is copy, Int:D $m where * < 0 --> Str) {
   my @digits;
   while $x {
      my $rem = $x % $m;
      $x = (($x - $rem) / $m).Int;
      ($rem, $x) = $rem - $m, $x + 1 if $rem < 0;
      @digits.unshift: $rem;
   }
   return @digits.join('');
}

=finish

multi sub b10-to-bm (Int:D $x is copy, Int:D $m where * > 0 --> Str) {
   my @digits;
   my $sign = '';
   ($sign, $x) = ('-', $x.abs) if $x < 0;
   while $x {
      @digits.unshift: my $rem = $x % $m;
      $x = (($x - $rem) / $m).Int;
   }
   @digits.unshift: $sign;
   return @digits.join('');
}

sub bm-to-b10 (Str:D $x is copy, Int:D $m --> Int) {
   my $sign = 1;
   my @digits = $x.comb;
   if ($m > 0 && @digits[0] eq '-') {
      @digits.shift;
      $sign = -1;
   }

   state %weight_for;
   if ! %weight_for.elems {
      %weight_for{$_} = .Int for 0 .. 9;
      %weight_for{$_} = 10 + .ord - 'a'.ord for 'a' .. 'z';
      %weight_for{$_} = 10 + .ord - 'A'.ord for 'A' .. 'Z';
   }

   my $retval = 0;
   for @digits -> $digit {
      $retval = $retval * $m + %weight_for{$digit};
   }
   return $sign * $retval;
}
