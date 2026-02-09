use v6 ;

sub find_pair( $number ) {
   if ( $number < 10 ) {
      return ( 0 , $number ) ;
   }
   else {
      my $root = $number ;
      my $persistence = 0 ;
      while ( $root > 9 ) {
         my @digits ;
         while ( $root != 0 ) {
            @digits.push( $root mod 10 ) ;
            $root div= 10 ;
         }
         $persistence++ ;
         $root = [+] @digits ;
      }
      return ( $persistence , $root ) ;
   }
}

say "Enter a positive integer!" ;
my $line = $*IN.get ;
my $number = $line.Int ;
my @result = find_pair( $number ) ;
say "Persistence  = " ~ ~@result[0] ;
say "Digital root = " ~ ~@result[1] ;

