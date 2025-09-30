use v6 ;

say "Enter a string and a letter from this string!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my $search_in = @words[0] ;
my $search_for = @words[1] ;
my $pos = $search_in.index( $search_for ) ;
my $firstPart = $search_in.substr( 0 , $pos + 1 ).comb.reverse.join( ) ;
my $secondPart = $search_in.substr( $pos + 1 ) ;
say $firstPart ~ $secondPart ;
