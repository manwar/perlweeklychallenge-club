use v6 ;

say "Please enter a string!" ;
my $str = $*IN.get ;
say "Please enter as many numbers as given by the length of the string!" ;
say "Numbers should go from 0 to <length of the string> - 1!" ;
my $numberstring = $*IN.get ;
my @numbers = $numberstring.words.map( {.Int} ) ;
my @pairs ;
for ( 0..$str.chars - 1 ) -> $pos {
   @pairs.push( Pair.new( @numbers[ $pos ] , $str.substr( $pos , 1 ) ) ) ;
}
my @letters = @pairs.sort( {$^a.key.Int <=> $^b.key.Int} ).map( {$_.value} ) ;
say join( '' , @letters ) ;
