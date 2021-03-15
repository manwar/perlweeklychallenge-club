#!/usr/bin/env raku

sub MAIN(Str $B, Int $S ) {

   die "$B not divisible by $S!" if $B.chars % $S != 0;

   my ( $min, $minh, $cost ) = (Inf, Inf, {});

   for ( $B.comb().rotor($S).combinations(2) ) -> ($f,$s) {
      my $df = 0;
      $df++ if ( $f[$_] ne $s[$_] ) for (^$f);
      $cost{ $f.join("") }{ $s.join("") } = $df;
      $cost{ $s.join("") }{ $f.join("") } = $df;
   }

   for ($cost.kv) -> $k,$v {
      my $tot = 0; 
      for ($v.kv) -> $kv,$vv {
         $tot += $vv 
      }
      if ( $tot < $min ) {
         $min = $tot if $tot < $min;
         $minh = $k;
      }
   }

   if ( $min != Inf ) {
      printf("Input: \$B = \"%s\", \$S = \"%d\"\n", $B, $S);
      printf("Output: %d\n\nBinary Substrings (aside from self: \"%s\"):\n", $min, $minh);
         
      for ( $cost{$minh}.kv ) -> $k,$v {
        if ( $k ne $minh ) {
            printf("   \"%s\": %d flip%s to make it \"%s\"\n", $k, $v, $v>1??"s"!!'', $minh);
        }
      }
      print("\n");
   }
}
