#!/usr/bin/env raku

sub MAIN() {

   my $t = 15;
   my @all = (1,2,3,4,5,6,7,8,9);
   my @workers;

   for @all -> $a { 
      push @workers, start {
         for ( @all (^) ($a) ).keys.grep({ ($a + $_) < $t }) -> $b {
            for ( @all (^) ($a,$b) ).keys -> $c {
               next if ($a + $b + $c) != $t;

               for ( @all (^) ($a,$b,$c) ).keys.permutations -> ($d,$e,$f,$g,$h,$i) {
                  if ( $t ==($d +$e +$f) ==($g +$h +$i) ==($a +$d +$g) ==($b +$e +$h) ==($c +$f +$i) ==($a +$e +$i) ==($c +$e +$g) ) {
                     ( ($a,$b,$c), ($d,$e,$f), ($g,$h,$i) ).join("\n").say;
                     print "\n";
                  }
               }

            }
         }
      }
   }

   await(@workers);

}
