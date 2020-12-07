#!/usr/bin/env raku

#
# see usage:
#
# pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-090/pkmnx/raku$ ./ch-2.raku 12 14
#      12       14  
#       6       28  
#       3       56 +
#       1      112 +
# Sum: 168
#

sub MAIN( Int $A, Int $B where ($A > 0 and $B > 0) ) {

   my $a = $A;
   my $b = $B;

   my @out = ();
   my $sum = 0;
   while ($a >= 1 ) {

     my $mod = !($a %% 2);
     if ( ( $a >= 1 ) && $mod ) {
        $sum += $b;
     }

     @out.push( [ $a, $b, $mod ??"+" !!" " ] );

     $a = ($a / 2).Int;
     $b *= 2;
   }

   my $amx = (@out).map(->($a,$b,$c){$a}).max.chars + 5;
   my $bmx = (@out).map(->($a,$b,$c){$b}).max.chars + 5;

   my $fn = sub ($a,$b) { ( sprintf ('%', $a, 's').join(""), $b ) };

   for (@out) ->($a,$b,$c) {
      ( $fn($amx, $a), $fn($bmx,$b), $c ).join(" ").say;
   }

   "Sum: $sum".say;

}
