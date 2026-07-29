use v6 ;

sub convert( $number is copy , $base is copy ) {
   my %conversions ;
   for (0..9) -> $i {
      %conversions{$i} = chr( $i + 48 ) ;
   }
   for (10..36) -> $i {
      %conversions{$i} = chr( $i + 55 ) ;
   }
   for (37..63) -> $i {
      %conversions{$i} = chr( $i + 61 ) ;
   }
   %conversions{ 64 } = '+' ;
   %conversions{ 65 } = '/' ;
   my $converted ;
   while ( $number != 0 ) {
      $converted ~= %conversions{$number % $base } ;
      $number div= $base ;
   }
   my $result ; 
   for $converted.comb.reverse -> $letter {
      $result ~= $letter ;
   }
   return $result ;
}

say "Enter a number and a base!" ;
my $line = $*IN.get ;
my ( $number , $base ) = $line.words.map( {.Int} ) ;
say convert( $number , $base ) ;
