#!/usr/bin/env raku

# usage: change @N & $N accordingly.

sub MAIN() {

   my @N = (11, 13, 15, 17);
   my $N = 19;

   my $indx = binsrch( @N, $N );
   my $vl = @N[$indx];

   printf( "Input: \@N = (%s) and \$N = %d\n", @N.join(", "), $N );

   if ( $N == $vl ) {
      say "Output: $indx since the target $N is in the array at the index $indx."
   } else {
      $indx++ if $N > $vl;
      say "Output: $indx since the target $N is missing and should be placed at the index $indx."
   }
 
}

sub binsrch( @N, $N ) {
   my ( $l, $r, $m )  = ( 0, @N.elems -1, -1 );
   while ( $l <= $r ) {
      $m =     Int( ($l +$r) / 2);
      my $vl = @N[$m];
      if    ( $vl < $N ) { $l = $m +1 }
      elsif ( $vl > $N ) { $r = $m -1 }
      else               { return $m  }
   }
   $m
}
