use v6 ;

sub isRepeating( $number is copy ) {
   if ( $number > 9 ) {
      my %frequencies ;
      my @digits ;
      while ( $number != 0 ) {
         my $remainder = $number mod 10 ;
         @digits.push( $remainder ) ;
         %frequencies{$remainder}++ ;
         $number div= 10 ;
      }
      return %frequencies.keys.elems != @digits.elems ;
   }
   else {
      return False ;
   }
}

say "Enter a positive integer!" ;
my $line = $*IN.get ;
my $number = $line.Int ;
my @selected = (1..$number).grep( { not ( isRepeating( $_ ) ) } ) ;
my $len = @selected.elems ;
my $maxi = 0 ;
for (1..$len - 1) -> $i {
   my $diff = @selected[$i] - @selected[$i - 1] ;
   if ( $diff > $maxi ) {
      $maxi = $diff ;
   }
}
say $maxi ;
   
