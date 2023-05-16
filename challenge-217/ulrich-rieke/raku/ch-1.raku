use v6 ;

say "Enter a square matrix of n x n elements, n >= 2 , end to end!" ;
my @allNumbers ;
my $line = $*IN.get ;
while ( $line ne "end" ) {
  my @numbers = $line.words ;
  for @numbers -> $num {
      @allNumbers.push( +$num ) ;
  }
  $line = $*IN.get ;
}
my @sorted = @allNumbers.sort( { $^a <=> $^b } ) ;
say @sorted[ 2 ] ;
