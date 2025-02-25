use v6 ;

sub isSimilar( @firstDom, @secondDom ) {
   return ( @firstDom[0] == @secondDom[0] && @firstDom[1] == @secondDom[1]) 
      || ( @firstDom[0] == @secondDom[1] && @firstDom[1] == @secondDom[0] ) ;
}

my @dominoes ;
say "Enter 2 integers, separated by blanks, to denote a domino!" ;
say "Enter <return> to end entry!" ;
my $line = $*IN.get ;
while ( $line ) {
   my @numbers = $line.words.map( {.Int} ) ;
   @dominoes.push( @numbers ) ;
   $line = $*IN.get ;
}
my $len = @dominoes.elems ;
my %indices ;
for (0..$len - 2 ) -> $i {
   for ( $i + 1 .. $len - 1 ) -> $j {
      if ( isSimilar( @dominoes[$i] , @dominoes[$j] ) ) {
	 %indices{$i}++ ;
	 %indices{$j}++ ;
      }
   }
}
say %indices.keys.elems ;
