#!/usr/bin/env raku
use v6;
sub MAIN (*@jumps) {
   @jumps = 'Perl', 2, 22, 19, 9 unless @jumps;
   my $word = @jumps.shift;
   put jumping-letters($word, @jumps);
}

sub jumping-letters ($word, @jumps) {
   state @bases = 'A'.ord, 'a'.ord;
   ($word.comb Z @jumps).map(-> ($c, $j) {
      my $old = $c.ord;
      my $base = @bases[$old >= @bases[1] ?? 1 !! 0];
      my $new = $base + (($old - $base + $j) % 26);
      $new.chr;
   }).join('');
}
