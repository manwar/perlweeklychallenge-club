use v6 ;

say "Enter a string!" ;
my $string = $*IN.get ;
say "Enter 26 character widths, separated by ','!" ;
my $widths = $*IN.get ;
my $characters = "abcdefghijklmnopqrstuvwxyz" ;
my @chars = $characters.comb ;
my @charlengths = $widths.split( ',' ).map( {.Int} ) ;
my $lineno = 1 ;
my $sum = 0 ;
my %letterwidths ;
for (0..25) -> $pos {
   %letterwidths{ @chars[ $pos ] } = @charlengths[ $pos ] ;
}
my $pixels = 0 ;
for ( $string.comb ) -> $char {
   $sum += %letterwidths{ $char } ;
   if ( $sum > 100 ) {
      $lineno++ ;
      $sum = %letterwidths{ $char } ;
   }
   if ( $sum == 100 ) {
      $lineno++ ;
      $sum = 0 ;
   }
}
if ( $sum == 0 ) {
   $lineno-- ;
}
$pixels = $sum ;
say "($lineno , $pixels)" ;

