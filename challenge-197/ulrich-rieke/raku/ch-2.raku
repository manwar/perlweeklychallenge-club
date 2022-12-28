use v6 ;

sub myCondition( @array --> Bool ) {
  my $len = @array.elems ;
  if ( $len == 3 ) {
      return @array[0] < @array[1] && @array[1] > @array[2] ;
  }
  if ( $len > 3 ) {
      for (0..$len - 2 ) -> $i {
    if ( $i %% 2 ) {
        unless ( @array[ $i ] < @array[ $i + 1 ] ) {
          return False ;
        }
    }
    else {
        unless ( @array[ $i ] > @array[ $i + 1 ] ) {
          return False ;
        }
    }
      }
  }
  return True ;
}

say "Enter some integers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ).map( {.Int} ) ;
while ( @numbers.elems < 3 ) {
  say "At least 3 numbers should be entered!" ;
  $line = $*IN.get ;
  @numbers = $line.split( /\s/ ).map( {.Int} ) ;
}
my %numberfrequencies ;
for @numbers -> $num {
  %numberfrequencies{ $num }++ ;
}
my $len = @numbers.elems ;
if ( $len > 3 && %numberfrequencies.values.max >= $len - 1 ) {
  say "Wiggle condition can't be fulfilled!" ;
}
else {
  my @permus = @numbers.permutations.map( {.Array} ) ;
  for @permus -> @subpermu {
      if ( myCondition( @subpermu ) ) {
    say '(' ~ @subpermu.join( ',' ) ~ ')' ;
      }
  }
}
