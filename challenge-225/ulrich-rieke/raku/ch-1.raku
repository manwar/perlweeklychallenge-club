use v6 ;

say "Enter some sentences! Enter fin to end!" ;
my @sentences ;
my $line = $*IN.get ;
while ( $line ne "fin" ) {
  if ( $line ~~ /^\S .+ \S$/ ) {
      @sentences.push( $line ) ;
  }
  else {
      say "No leading or trailing spaces, please! Re-enter!" ;
  }
  $line = $*IN.get ;
}
say @sentences.map( {.words} ).map( {.elems} ).max ;
