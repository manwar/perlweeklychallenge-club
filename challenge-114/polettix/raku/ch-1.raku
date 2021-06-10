#!/usr/bin/env raku
use v6;

sub next-palindrome-number (IntStr $N) {
   my $l = $N.chars;
   return '1' ~ ('0' x ($l - 1)) ~ '1' unless $N ~~ m{<[0 .. 8]>};
   my $n = $N.substr(0, $l / 2);
   my $mid = $l % 2 ?? $N.substr($l / 2, 1) !! '';

   # just try to build straight from the inputs...
   if (my $candidate = $n ~ $mid ~ $n.flip) > $N {
      return $candidate;
   }

   # if there's a "$mid", try increasing that
   if ($l % 2) {
      return $n ~ ($mid + 1) ~ $n.flip if $mid < 9;
      $mid = 0;
   }

   ++$n;
   return $n ~ $mid ~ $n.flip;
}

sub MAIN (*@inputs is copy) {
   @inputs.push(1234) unless @inputs.elems;
   next-palindrome-number($_).say for @inputs;
}
