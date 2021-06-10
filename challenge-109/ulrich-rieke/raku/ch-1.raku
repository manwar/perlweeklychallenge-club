use v6 ;

sub chowladivisors( Int $n ) {
  if ( $n (elem) Set( 1 , 2 , 3 ) ) {
      return ( ) ;
  }
  else {
      my @divisors = ( ) ;
      for (2 .. $n - 1 ) -> $i {
    if ( $n %% $i ) {
        @divisors.push( $i ) ;
    }
      }
      return @divisors ;
  }
}

my @chowlanumbers = ( ) ;
my $n = 0 ;
repeat {
  $n++ ;
  my @div = chowladivisors( $n ) ;
  if ( @div ) {
      @chowlanumbers.push( @div.sum ) ;
  }
  else {
      @chowlanumbers.push( 0 ) ;
  }
} until ( @chowlanumbers.elems == 20 ) ;
say @chowlanumbers ;
