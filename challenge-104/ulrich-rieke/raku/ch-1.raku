use v6 ;

my @fusc ;
@fusc.push( 0 , 1 ) ;
for (2 .. 49 ) -> $n {
  if ( $n %% 2 ) {
      @fusc[ $n ] = @fusc[ $n div 2 ] ;
  }
  else {
      my $half = $n div 2 ;
      @fusc[ $n ] = @fusc[ $half ] + @fusc[ $half + 1 ] ;
  }
}
say @fusc ;
