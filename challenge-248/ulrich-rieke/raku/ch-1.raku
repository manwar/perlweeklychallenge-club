use v6 ;

say "Enter a string and a letter from this string, separated by a blank!" ;
my $line = $*IN.get ;
my @parts = $line.words ;
my $string = @parts[ 0 ] ;
my $letter = @parts[ 1 ] ;
my @result ;
my @letterpositions ;
my $pos = 0 ;
for $string.comb -> $current {
   if ( $current eq $letter ) {
      @letterpositions.push( $pos ) ;
   }
   $pos++ ;
}
$pos = 0 ;
for $string.comb -> $current {
   if ( $current ne $letter ) {
      my @differences = @letterpositions.map( { abs( $_ - $pos) } ) ;
      @result.push( @differences.min ) ;
   }
   else {
      @result.push( 0 ) ;
   }
   $pos++ ;
}
say ( "(" ~ @result.join( ',' ) ~ ")" ) ;
