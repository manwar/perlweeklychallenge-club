use v6 ;

#eliminate one of the values if a number > 0 meets a number < 0
#we assume this to be the case since we checked for this condition
#in the main branch
sub eliminate_values( @array ) {
  my @after_elimination ;
  my $len = @array.elems ;
  my $pos = 0 ;
  while ( not ( @array[ $pos ] > 0 && @array[ $pos + 1 ] ) < 0 ) {
      @after_elimination.push( @array[ $pos ] ) ;
      $pos++ ;
  }
  my $diff = abs( @array[ $pos ] ) - abs( @array[ $pos + 1 ] ) ;
  if ( $diff > 0 ) {
      @after_elimination.push( @array[ $pos ] ) ;
  }
  elsif ( $diff == 0 ) {
  }
  else {
      @after_elimination.push( @array[ $pos + 1 ] ) ;
  }
  $pos += 2 ;
  if ( $pos < $len ) {
      while ( $pos < $len ) {
    @after_elimination.push( @array[ $pos ] ) ;
    $pos++ ;
      }
  }
  return @after_elimination ;
}

#can we perform a collision ?
sub needs_no_collisions( @numbers ) {
  my @indices ;
  for (0..@numbers.elems - 2 ) -> $i {
      @indices.push( $i ) ;
  }
  return @indices.grep( { not ( @numbers[ $_ ] > 0 && @numbers[ $_ + 1 ] < 0 ) } ).elems
      == @indices.elems ;
}

say "Enter some positive and negative integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @after_collision = eliminate_values( @numbers ) ;
while ( not needs_no_collisions( @after_collision ) ) {
  @after_collision = eliminate_values( @after_collision ) ;
}
if ( @after_collision ) {
  print '(' ;
  print join( ',' , @after_collision ) ;
  say ')' ;
}
else {
  say "()" ;
}
