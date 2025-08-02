use v6 ;

say "Enter some strings , <return> to end!" ;
my $line = $*IN.get ;
my @strings ;
while ( $line ) {
   @strings.push( $line ) ;
   $line = $*IN.get ;
}
my @shuffled ;
for @strings -> $inline {
   my @shuffled_row ;
   for ( $inline.split( /\s/ )) -> $word {
      if ( $word.chars <= 3 ) {
	 @shuffled_row.push( $word ) ;
      }
      else {
	 my $shuffled = $word.substr( 0 , 1 ) ;
	 my @in_between = $word.substr( 1 , $word.chars - 2 ).comb ;
	 @in_between = @in_between.pick: * ;
	 $shuffled ~= ( @in_between.join ~ $word.substr( $word.chars - 1 , 1 ) ) ;
	 @shuffled_row.push( $shuffled ) ;
      }
   }
   @shuffled.push( @shuffled_row.join( ' ' ) ) ;
}
@shuffled.map( {.say} ) ;
