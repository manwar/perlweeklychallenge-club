use v6 ;
#to find the prime factors of a given number , keep dividing the number
#by its smallest current divisor which , for obvious reasons, must be a 
#prime number 
sub findFactors( $number is copy , $mode ) {
   my @primefactors ;
   my $divisor = 2 ;
   while ( $number != 1 ) {
      if ( $number %% $divisor ) {
         @primefactors.push( $divisor ) ;
         $number div= $divisor ;
      }
      else {
         $divisor++ ;
      }
   }
   if ( $mode == 0 ) {
      my %uniquefactors ;
      @primefactors.map( { %uniquefactors{$_}++ } ) ;
      return %uniquefactors.keys.elems ;
   }
   else {
      return @primefactors.elems ;
   }
}

say "Enter a number!" ;
my $numberline = $*IN.get ;
my $number = $numberline.Int ;
say "Enter a mode( 0 or 1 )!!" ;
my $modeline = $*IN.get ;
my $mode = $modeline.Int ;
say findFactors( $number , $mode ) ;
