use v6 ;

sub convert( $word , $shift ) {
   my @numbers = $word.comb.map( {.ord} ) ;
   my @converted ;
   for @numbers -> $num {
      my $shifted = $num + $shift ;
      if ($shifted > 64 && $shifted < 91) ||
            ( $shifted > 96 && $shifted < 123 ) {
         @converted.push( chr( $shifted ) ) ;
      }
      else {
         if ( $shifted > 90 && $shifted < 97 ) {
            @converted.push( chr( ($shifted % 91) + 65 )) ;
         }
         if ( $shifted > 122 ) {
            @converted.push( chr( ($shifted % 123) + 97 )) ;
         }
      }
   }
   return @converted.join( '' ) ;
}

say "Enter a word consisting of ASCII alphabetic characters only!" ;
my $word = $*IN.get ;
say "Enter a positive integer!" ;
my $numberline = $*IN.get ;
my $number = +$numberline ;
say convert( $word , $number ) ;
