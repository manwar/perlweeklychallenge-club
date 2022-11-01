use v6 ;

sub findDegree( @array --> Int) {
  my %frequencies ;
  for @array -> $el {
      %frequencies{ $el }++ ;
  }
  return %frequencies.values.max( ) ;
}

say "Enter some non-negative integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ) ;
my @subarrays ;
my $degree = findDegree( @numbers ) ;
if ( $degree == 1 ) {
  say @numbers.min ;
}
else {
  my $arraylen = @numbers.elems ;
  for ( $degree .. $arraylen) -> $stepwidth {
      for (0..$arraylen - $stepwidth) -> $start {
    my @subarray ;
    for ( 0..$stepwidth - 1 ) -> $pos {
        @subarray.push( @numbers[ $start + $pos ] ) ;
    }
    if ( findDegree( @subarray ) == $degree ) {
        @subarrays.push( @subarray ) ;
    }
      }
  }
  my @sortedArrays = @subarrays.sort: *.sum ;
  say @sortedArrays[0] ;
}
