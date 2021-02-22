use v6 ;

sub enterArray( ) {
  say "Enter an array of integers( just in a line, <n> <n> )!" ;
  my $input = $*IN.get ;
  my @array = $input.split(/\s+/).map( {.Int} ).unique.sort( {$^a <=> $^b} ) ;
  return @array ;
}

sub MAIN( Int $N ) {
  my @N = enterArray( ) ;
  my $index ;
  my %numhash ;
  for @N -> $num {
      %numhash{ $num }++ ;
  }
  if ( %numhash{$N}:exists ) {
      my $i = -1 ;
      repeat {
    $i++ ;
      } until ( @N[ $i ] == $N ) ;
      $index = $i ;
  }
  else {
      $index = @N.grep( { $_ < $N } ).elems ;
  }
  say $index ;
}
