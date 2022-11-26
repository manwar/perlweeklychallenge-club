use v6 ;

sub findIn( @haystack , $needle ) {
  my $pos = 0 ;
  while ( @haystack[ $pos ] != $needle ) {
      $pos++ ;
  }
  return $pos ;
}

say "Please enter some numbers greater than or equal to zero!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ).map( {.Int} ) ;
#if the sum of numbers cannot be evenly divided by the number of elements
#there is no solution
#otherwise: find the maximum of the numbers. Add 1 to the smaller of the
#two neighbours if there are 2 , otherwise to the next cell to the left
#or to the right if the maximum is at the end or the beginning of the list
#if there are 2 neighbours and they are both equal find the minimum of the
#list and subtract 1 from the neighbour on the side of the minimum; otherwise
#one might incur endless loops
if ( not (@numbers.sum %% @numbers.elems) ) {
  say -1 ;
}
else {
  if ( @numbers.grep( { $_ == @numbers[0] } ).elems == @numbers.elems ) {
      say 0 ;
  }
  else {
      my $count = 0 ;
      my $len = @numbers.elems ;
      repeat {
    my $maximum = @numbers.max ;
    my $maxIndex = findIn( @numbers, $maximum ) ;
    @numbers[ $maxIndex ]-- ;
    given $maxIndex {
        when 0 { @numbers[1]++ }
        when ($len - 1) { @numbers[ * -2 ]++ }
        default {
          if ( @numbers[ $maxIndex - 1 ] < @numbers[ $maxIndex + 1 ] ) {
          @numbers[ $maxIndex - 1]++ ;
          }
          elsif ( @numbers[ $maxIndex - 1 ] > @numbers[ $maxIndex + 1 ] ) {
          @numbers[ $maxIndex + 1 ]++ ;
          }
          else {
          my $minimum = @numbers.min ;
          my $minIndex = findIn( @numbers , $minimum ) ;
          if ( $minIndex < $maxIndex ) {
            @numbers[ $maxIndex - 1 ]++ ;
          }
          else {
            @numbers[ $maxIndex + 1 ]++ ;
          }
          }
        }
    }
    $count++ ;
      } until ( @numbers.grep( { $_ == @numbers[ 0 ] } ).elems == $len ) ;
      say $count ;
  }
}
