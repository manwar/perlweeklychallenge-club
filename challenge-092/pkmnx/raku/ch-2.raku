#!/usr/bin/env raku

# see usage:
#
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-092/pkmnx/raku$ echo "(1,5), (7,9)  (10,11)" | ./ch-02.raku 
#  Input $S = (1,5), (7,9); $N = (10,11)
#  Output: (1,5), (7,9), (10,11)
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-092/pkmnx/raku$ echo "(1,2), (3,7), (8,10); $N = (5,8)" | ./ch-02.raku 
#  Input $S = (1,2), (3,7), (8,10); $N = (5,8)
#  Output: (1,2), (3,10)
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-092/pkmnx/raku$ echo "Input $S = (1,4), (8,10); $N = (2,6)" | ./ch-02.raku 
#  Input $S = (1,4), (8,10); $N = (2,6)
#  Output: (1,6), (8,10)

sub MAIN () {

   my $cnt = 0;
   my $ar = [];
   for lines() -> $l {
      for ( $l ~~ m:g/ (\-*\d+) \s* ','\s* (\-*\d+) / ) -> ($m,$n) {
         $ar.push( ($m +0, $n +0).sort({ $^a <=> $^b }) );
         $cnt++;
      }
   }
   die "not enough nums to process!" if $cnt < 2;

   my $display = {};

   my $stopReducing = False;
   repeat {

     if ($ar.elems) {
        my $tail = $ar.pop;
   
        if ( !$display ) { 
           $display = { t => $tail, ar => $ar };
        }

        my $nar = [];
        $ar.sort({ $^a[0] <=> $^b[0] }).map({ $nar.push($_) });
        $ar = $nar;

        my $cnt = 0;
        for (^$ar.elems ) -> $in {
           my $it = $ar[$in];
           if ( $tail and  $tail[0] >= $it[0] and $tail[0] <= $it[1] ) {
              if ( $tail[1] >= $it[1] ) {
                 $ar[$in] = ( $it[0], $tail[1] );
              }
              $cnt++;
           }
        }

        if ( $cnt == 0 ) {
           $ar.push($tail);
           $stopReducing = True;
        }
     }

   } until $stopReducing;

  
   my $dFn = sub ($in) { $in.map({ "(" ~ $_.join(",") ~ ")" }).join(", ") };

   printf( "Input \$S = %s; \$N = (%s)\n", $dFn($display{"ar"}), $display{"t"}.join(",") );
   printf( "Output: %s\n", $dFn($ar) );

}
