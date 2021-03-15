#!/usr/bin/env raku

my $S = "littleit";
my $T = "lit";

#my $S = "london"; 
#my $T = "lon";

my $outp = find( $S, $T );

printf( "Input: \$S = \"%s' \$T = '%s'\n", $S, $T );
printf( "Output: %d\n\n", $outp.elems );

for (^$outp.elems) {
   printf(" %4s: %s\n", $_ +1, $outp[$_] );
}

sub find( $S, $T ) { 
   my $outr = [];
   unqsubsq( $S, 0, $T, 0, "", $outr );
   return $outr;
}

sub unqsubsq( $inp, $i, $mt, $j, $outp, $outr ) {
   if ( $i > $inp.chars && $j >= $mt.chars ) {
      $outr.prepend($outp);
      return;
   }
   return if $i > $inp.chars;
   my ( $iv, $jv, $noutp ) = ( $inp.substr($i,1), $mt.substr($j,1), $outp );
   if ( $iv.chars > 0 and $iv ~~ $jv ) {
      unqsubsq( $S, $i+1, $T, $j, $noutp~$iv, $outr );
      my $nc = "[$iv]";
      if ( $outp.chars > 0 ) {
         my $lastChar = ($outp.comb)[$outp.chars -1];
         if  ( $lastChar ~~ "]" ) {
            $noutp = $noutp.subst( /\]$/, "" );
            $nc = "$iv]";
         }
      }
      unqsubsq( $S, $i+1, $T, $j+1, $noutp~$nc, $outr );
   } else {
      unqsubsq( $S, $i+1, $T, $j, $noutp~$iv, $outr );
   }
}
