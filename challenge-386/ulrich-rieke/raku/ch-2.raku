use v6 ;

sub parse( $rational is copy) {
   my @parts ;
   my $pointpos = $rational.index( "." ) ;
   @parts.push( $rational.substr( 0 , $pointpos )) ;
   my $bracketopen = $rational.index( "(" ) ;
   if ( $bracketopen ) {
      @parts.push( $rational.substr( $pointpos + 1 , $bracketopen - $pointpos - 1)) ;
      @parts.push( $rational.substr( $bracketopen + 1 , $rational.chars - 
               $bracketopen - 2 )) ;
   }
   else {
      @parts.push( "" ) ;
      @parts.push( "" ) ;
   }
   return @parts ;
}

sub areSame( $firstnumber is copy , $secondnumber is copy) {
   my @firstparts = parse( $firstnumber ) ;
   my @secondparts = parse( $secondnumber ) ;
   if ( @secondparts[1] eq "" && @secondparts[2] eq "" ) {
      if ( (@firstparts[1] ~~ /^9+$/ || @firstparts[1] eq "" ) && 
            @firstparts[2] ~~ /^9+$/ ) {
         return @secondparts[0].Int == @firstparts[0].Int + 1 ;
      }
   }
   else {
      my $firstexpanded = @firstparts[0] ~ "." ~ @firstparts[1] ;
      my $secondexpanded = @secondparts[0] ~ "." ~ @secondparts[1] ;
      if ( @firstparts[2].chars != 3 ) {
         $firstexpanded ~= ( @firstparts[2] x 4 ) ;
      }
      else {
         $firstexpanded ~= ( @firstparts[2] x 3 ) ;
      }
      if ( @secondparts[2].chars != 3 ) {
         $secondexpanded ~= ( @secondparts[2] x 4 ) ;
      }
      else {
         $secondexpanded ~= ( @secondparts[2] x 3 ) ;
      }
      return ( $firstexpanded.substr( 0 , $secondexpanded.chars ) eq $secondexpanded ) 
            || ($secondexpanded.substr( 0 , $firstexpanded.chars ) eq $firstexpanded ) ;
   }
}

say "Enter a rational number!" ;
my $rat1 = $*IN.get ;
say "Enter a second rational number!" ;
my $rat2 = $*IN.get ;
say areSame( $rat1 , $rat2 ) ;
