use v6 ;

say "Enter some integers as part of a matrix, same number each line, end to end!" ;
my $line = $*IN.get ;
my @matrix ;
while ( $line ne "end" ) {
  my @numbers = $line.words.map( {.Int} ) ;
  @matrix.push( @numbers ) ;
  say "Enter some integers, end to end!" ;
  $line = $*IN.get ;
}
my @diagonals ;
my $len = @matrix.elems ;
for (0..$len - 1 ) -> $i {
  @diagonals.push( @matrix[$i][$i] ) ;
}
if ( @diagonals.grep( { $_ == @diagonals[0] } ).elems == $len ) {
  say "true" ;
}
else {
  say "false" ;
}
