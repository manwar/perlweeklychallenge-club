use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my %wordpos ;
my $len = $word.chars ;
for (0..$len - 1) -> $pos {
   %wordpos{$word.substr( $pos , 1 ) }.push( $pos ) ;
}
my @solution ;
for ( 0..$len - 1) -> $pos {
   my $part = $word.substr( $pos , 1 ) ;
   my @positions ;
   %wordpos{$part}.map( {@positions.push( $_ )} ) ;
   if ( @positions.elems >= 3 && isAscending( @positions )) {
      my $string = $part x @positions.elems ;
      @solution.push( $string ) ;
   }
}
if ( @solution ) {
   say @solution.unique.join( ',' ) ;
}
else {
   say "\"\"" ;
}

sub isAscending( @array ) {
   my $len = @array.elems ;
   for ( 0..$len - 2 ) -> $pos {
      if ( @array[$pos + 1] - @array[$pos] != 1 ) {
	 return False ;
      }
   }
   return True ;
}
