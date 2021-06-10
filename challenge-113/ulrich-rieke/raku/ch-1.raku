use v6 ;

sub MAIN( Int $N , Int $D ) {
  if ( $N == $D ) {
      say 1 ;
      exit( 1 ) ;
  }
  else {
#find numbers below $N containing $D
      my @possibleNumbers = (1 .. $N ).grep( { ~$_ ~~ /$D/ } ) ;
      if (@possibleNumbers.elems == 1 ) {
    say 0 ; #no valid sum, only one number contains $D
    exit( 0 ) ;
      }
      if ( @possibleNumbers.elems == 2 ) {
    if ( @possibleNumbers[0] + @possibleNumbers[1] == $N ) {
        say 1 ;
        exit( 0 ) ;
    }
    else {
        say 0 ;
        exit( 1 ) ;
    }
      }
      if ( (my $nums = @possibleNumbers.elems) > 2 ) {
#there can be combinations of 2 and more that sum up to $D
    for ( 2 .. $nums ) -> $i {
        my @combis = @possibleNumbers.combinations($i ) ;
        for @combis -> $combi {
          if ( ([+] $combi) == $N ) {#valid combination found
          say 1 ;
          exit( 0 ) ;
          }
        }
    }
      }
      say 0 ;#nothing found , everything else would have returned already
  }
}
