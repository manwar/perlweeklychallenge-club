use v6 ;

say "Enter a list of numbers, separated by a blank!" ;
my $row = $*IN.get ;
while ( $row !~~ /^\s* \d+ % ' ' $/ ) {
  say "You should enter numbers only, separated by a blank!" ;
  $row = $*IN.get ;
}
my @numbers = $row.split( /\s/ ).map( {.Int} ) ;
say @numbers.combinations( 2 ).unique.map( { @_[0] +& @_[1] } ).sum ;
