use v6 ;

sub findOctal( Num $number , @octals --> Int ) {
  my Int $current = 0 ;
  while ( @octals[$current] < $number ) {
      $current++ ;
      last if $current == 8 ;
  }
  if ( $current == 8 ) {
      return 7 ;
  }
  else {
      return $current ;
  }
}

say "Please enter a numbers of positive numbers , separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/).map( {.Num} ) ;
my $max = @numbers.max ;
my $min = @numbers.min ;
my $range = $max - $min ;
my @octals ;
@octals.push( $min ) ;
for ( 1 .. 7 ) -> $i {
  @octals.push( $range / 8 * $i ) ;
}
@octals.push( $max ) ;
my @blockCodePoints = ( 0x2581 , 0x2582, 0x2583 , 0x2584 ,
      0x2585 , 0x2586 , 0x2587 , 0x2588) ;
my @octalQuantiles = @numbers.map( { findOctal( $_ , @octals ) } ) ;
for @octalQuantiles[0 .. @octalQuantiles.elems - 2] -> $octal {
  print @blockCodePoints[ $octal ].chr ;
}
say @blockCodePoints[ @octalQuantiles[*-1]].chr ;
