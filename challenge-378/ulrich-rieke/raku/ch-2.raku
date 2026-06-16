use v6 ;

sub toNumber( $word is copy) {
   return $word.comb.map( {$_.ord( ) - 97} ).join( '' ).Int ;
}

say "Enter 3 strings consisting of lowercase English letters a to j only!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my @numbers ;
for @allWords -> $w {
   @numbers.push( toNumber( $w ) ) ;
}
say (@numbers[0] + @numbers[1] == @numbers[2]) ;
