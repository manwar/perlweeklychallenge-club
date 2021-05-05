use v6 ;
sub enterMatrix {
  my @matrix ;
  say "Enter 25 numbers in a 5 by 5 matrix, ordered by row!" ;
  for (0 .. 4 ) {
      say "Enter 5 numbers, separated by a blank! " ;
      my @numbers = $*IN.get.split(/\s+/) ;
      @matrix.push(  |@numbers  ) ;
  }
  return @matrix ;
}

my @matrix = enterMatrix( ) ;
my $number = prompt "Enter a number to search for: " ;
my $lower = 0 ;
my $upper = @matrix.elems - 1 ;
my $middle = ($upper + $lower) div 2 ;
repeat {
  if ( $number > @matrix[ $middle ] ) {
      $lower = $middle ;
  }
  if ( $number < @matrix[ $middle ] ) {
      $upper = $middle ;
  }
  if ( @matrix[ $middle ] != $number ) {
      $middle = ($upper + $lower) div 2 ;
  }
} until ( @matrix[ $middle ] == $number or ( $upper - $lower ) == 1 ) ;
if ( @matrix[ $middle ] == $number ) {
  say "1 as it exists in the matrix" ;
}
if ( $upper - $lower == 1 ) {
  if ( @matrix[ $lower ] == $number or @matrix[ $upper ] == $number ) {
      say "1 as it exists in the matrix" ;
  }
  else {
      say "0 since it is missing in the matrix" ;
  }
}
