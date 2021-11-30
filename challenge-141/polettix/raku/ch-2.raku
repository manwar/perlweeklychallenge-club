#!/usr/bin/env raku
use v6;

sub MAIN (Int:D $m = 1234, Int:D $n = 2) {
   like-numbers($m, $n).put;
}

sub like-numbers (Str() $m, Int:D $n) {
   my @m = $m.comb(/\d/);
   my $bits = @m.elems;
   my $template = '%0' ~ $bits ~ 'b';
   my $N= 2 ** $bits - 1;
   my $c = 0;
   for 0 ^..^ $N -> $i {
      my @b = $template.sprintf($i).comb(/<[0 1]>/);
      my $v = (0 .. @m.end).map({ @b[$_] > 0 ?? @m[$_] !! '' }).join('');
      ++$c if $v %% $n;
   }
   return $c;
}
