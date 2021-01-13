#!/usr/bin/env rakudo
#
# use: ./ch-1.raku 100 4 50 3 2
#

sub MAIN( *@N where @N.elems >= 2 && all(@N) ~~ Int ) { 

   my @input = @N;
   my $input = @input.join(", ");
   "Input: @N = ($input)".say;

   @N = @N.Set.keys.sort;

   my $s = gather {
      take 0;
      for ( 1 .. @N.elems -1) {
         my $diff = abs( abs(@N[$_ -1]) - abs(@N[$_]) );
         take ( $diff == 1 ?? $diff !! 0 );
      }
   }.join();

   if ( $s ~~ /1/ ) {

      my $mx = ($s ~~ m:g/1*/).grep({ $_.chars >0 }).max;
      my $indx = $s.index( $mx ) -1;
      my $fnd = @N[ ($indx ) .. ($indx + $mx.chars) ].join(", ");
      "Output: ($fnd)".say;
   } else {
      "Output: 0".say;
   }
 
}
