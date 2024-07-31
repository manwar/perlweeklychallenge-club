use v6 ;

sub createPair( $word ) {
   my @pair;
   if ( $word ~~ /^(\D+)(\d+)$/ ) {
      @pair = [ ~$/[0] , +$/[1] ] ;
   }
   return @pair ;
}

say "Enter a line of words with ending numbers!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my @pairs = @allWords.map( {createPair( $_ )} ) ;
my @sorted = @pairs.sort( *.[1] ) ;
my $output ;
for @sorted -> @p {
   $output ~= @p[0] ~ " " ;
}
say $output ;
