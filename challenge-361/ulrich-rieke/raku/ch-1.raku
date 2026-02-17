use v6 ;

sub fibonacci( $number ) {
   if ( $number == 0 ) {
      return 0 ;
   }
   if ( $number == 1 ) {
      return 1 ;
   }
   if ( $number > 1 ) {
      return fibonacci( $number - 2 ) + fibonacci( $number - 1 ) ;
   }
}

sub findFirst( @fibos , $number ) {
   my $pos = 0 ;
   while ( @fibos[$pos] > $number ) {
      $pos++ ;
   }
   return @fibos[$pos] ;
}

say "Enter a number <= 100!" ;
my $line = $*IN.get ;
my $number = $line.Int ;
my @fibonaccis ;
for (0..12 ) -> $n {
   @fibonaccis.push( fibonacci( $n ) ) ;
}
@fibonaccis .= reverse ;
my @result ;
while ( $number != 0 ) {
   @result.push( findFirst( @fibonaccis, $number ) ) ;
   $number -= @result[*-1] ;
}
say @result.join( ',' ) ;

