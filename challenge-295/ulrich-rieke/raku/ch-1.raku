use v6 ;

say "Enter a long word!" ;
my $word = $*IN.get ;
say "Enter some words separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @selected = @words.grep( {$word.index($_) ~~ Int} ) ;
if ( @selected.elems != @words.elems ) { 
   say False ;
}
else {
   my @positions ;
   for @words -> $w {
      my $pos = $word.index( $w ) ; ;
      while ( $pos ~~ Int ) {
	 my @array = ($pos, $w) ;
	 @positions.push(@array) ;
	 if ( $pos < $word.chars - 2 ) {
	    $pos++ ;
	 }
	 $pos = $word.index( $w , $pos ) ;
      }
   }
   my @allIndices ;
   for @positions -> @position {
      my @indices = (@position[0]..@position[0] + @position[1].chars - 1)  ;
      @allIndices.push( @indices ) ;
   }
   my $result = True ;
   for (0..@allIndices.elems - 2) -> $pos {
      my $firstSet = @allIndices[$pos].Set ;
      my $secondSet = @allIndices[$pos + 1].Set ;
      my $common = $firstSet (&) $secondSet ;
      if ( $common.elems > 0 ) {
	 $result = False ;
	 last ;
      }
   }
   say $result ;
}
