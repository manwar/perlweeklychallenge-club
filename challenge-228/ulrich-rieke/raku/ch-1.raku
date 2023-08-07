use v6 ;

sub count( @haystack , $needle ) {
   return @haystack.grep( { $_ == $needle} ).elems ;
}

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say @numbers.grep( { count( @numbers , $_ ) == 1 } ).sum ;
