use v6 ;
say "Enter some integers , separated by blanks! Enter end to stop entry!" ;
my $line = $*IN.get ;
my @numbers ;
while ( $line ne "end" ) {
  @numbers.push( |$line.words.map( {.Int} ) ) ;
  $line = $*IN.get ;
}
say @numbers ;
say "Enter a row and a column number , separated by blanks!" ;
$line = $*IN.get ;
my ( $r , $c ) = $line.words.map( {.Int} ) ;
if ( not ( @numbers.elems %% ( $r * $c ) ) ) {
  say 0 ;
}
else {
  if ( $r == 1 ) {
      say '(' ~ join( ',' , @numbers ) ~ ')' ;
  }
  else {
      say @numbers.rotor( $c ) ;
  }
}
