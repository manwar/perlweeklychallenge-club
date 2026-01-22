use v6 ;

#simplify so that there are no common divisors shared by $numerator and 
#$denominator
#returns an array with $numerator and $denominator after reduction
sub simplify( $numerator , $denominator ) {
   my $commondivisor = $numerator gcd $denominator ;
   if ( $commondivisor != 1 ) {
      return ( $numerator div $commondivisor , $denominator div 
            $commondivisor ) ;
   }
   else {
      return ( $numerator , $denominator ) ;
   }
}

say "Enter a positive integer!" ;
my $line = $*IN.get ;
my $number = +$line ;
my @fractions ;
for (1..$number) -> $num {
   for (1..$number ) -> $denom {
      @fractions.push( ($num / $denom , $num , $denom)) ;
   }
}
@fractions .= sort: {@_[0]} ;
my @converted = @fractions.map( {simplify( $_[1] , $_[2] )} ) ;
my @output = @converted.map( {$_[0] ~ "/" ~ $_[1]} ) ;
@output .= unique ;
say @output.join( ", " ) ;
