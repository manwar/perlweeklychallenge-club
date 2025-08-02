use v6 ;

sub allEqual( @array ) {
   my $first = @array[0] ;
   return @array.elems == @array.grep( {$_ eq $first} ).elems ;
}

say "Enter 3 strings with equal length!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @firstLetters ;
for @words -> $w {
   @firstLetters.push( $w.substr( 0 , 1 ) ) ;
}
if ( not allEqual( @firstLetters ) ) {
   say -1 ;
}
else {
   my @allWordstarts ;
   my $shortest = @words.map( {$_.chars} ).min ;
   for (1..$shortest ) -> $len {
      my @substrings = @words.map( {$_.substr( 0 , $len )} ) ;
      if ( allEqual( @substrings ) ) {
	 @allWordstarts.push( @substrings[0] ) ;
      }
   }
   @allWordstarts .= sort( {$^b.chars <=> $^a.chars } ) ;
   my $maxCommon = @allWordstarts[0].chars ;
   say @words.map( {$_.chars - $maxCommon}).sum ;
}
