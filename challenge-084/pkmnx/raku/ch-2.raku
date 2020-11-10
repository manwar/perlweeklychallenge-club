#!/usr/bin/env rakudo

# see usage:
# pk@pkx:/tmp$ cat poo
# [ 0 1 0 1 ]
# [ 0 0 1 0 ]
# [ 1 1 0 1 ]
# [ 1 0 0 1 ]
# pk@pkx:/tmp$ ./ch-2.raku < poo
# Input:
# (0 1 0 1)
# (0 0 1 0)
# (1 1 0 1)
# (1 0 0 1)
# 
# Output: 1
# There is one square (3x3).
# r=1, c=2

sub MAIN() {

   my @data = ();
   for $*IN.lines() -> $l {
      @data.push( $l.split("").grep: /^0|1$/ );
   }

   my $fcnt = 0;
   my %found;
   for ( 0 .. @data.end ) -> $j {
      for ( 0 .. @data.end ) -> $k {
         for ( 1 .. @data.end ) -> $l {
            my $a = @data[ $j     ][ $k ];
            my $b = @data[ $j     ][ $k +$l ];
            my $c = @data[ $j +$l ][ $k ];
            my $d = @data[ $j +$l ][ $k +$l ];

            if ( $a && $b && $c && $d ) { 
               if ( $a == 1 && $b == 1 && $c == 1 && $d == 1 ) {
                  %found{$l +1}.push([ $j +1, $k +1 ]);
                  $fcnt++;
               }
            }

         }
      }
   }

   say "Input:";
   for ( 0 .. @data.end ) -> $j {
      say @data[$j];
   }
   say "";

   if ( $fcnt > 0 )  {
      say "Output: $fcnt";
      for %found.keys.sort({ $^b <=> $^a }) -> $k {
         my @fnd = @( %found{$k} );
         my ($r, $c) = @fnd;

         my $fndcnt = @fnd.elems;
         say "There " ~ ( $fndcnt > 1 ??"are $fndcnt squares (" !!"is one square (" ) ~ $k ~ 'x' ~ $k ~ ").";
         say @fnd.map(-> $k { "r=$k[0], c=$k[1]" }).join("; ");
         say "";

      }
   } 
   else {
      say "Output: 0";
   }

}
