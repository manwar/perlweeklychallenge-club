use v6 ;

#the solution algorithm is: if only 1 integer is entered, it is the solution
#if 2 ints are entered, select the smaller of the 2 and form a product with
#the neighbours correspondingly
#if 3 integers are entered, remove the middle one and continue as above
#if more than 3 integers, remove the smallest of them and form products with
#the neighbours. If the smallest integers occurs more than once, select the
#one with the biggest product with the neighbours

sub findPos( @array ) {
  my $len = @array.elems ;
  given $len {
      when 1 { return 0 ;
      }
      when 2 {
    my $minimum = @array.min ;
    if ( $minimum == @array[ 0 ] ) {
        return 0 ;
    }
    else {
        return 1 ;
    }
      }
      when 3 {
    return 1 ;
      }
      default {
    my $minimum = @array.min ;
    my $howmany = find( @array , $minimum ) ;
    if ( $howmany > 1 ) {
        my $maxpos = 0 ;
        my $maxProduct = 0 ;
        for (1..$len - 2 ) -> $i {
          if ( @array[ $i ] == $minimum ) {
          my $product = [*] @array[ $i - 1 , $i + 1 ] ;
          if ( $product > $maxProduct ) {
            $maxProduct = $product ;
            $maxpos = $i ;
          }
          }
        }
        return  $maxpos ;
    }
    else {
        for (0..$len - 1 ) -> $i {
          if ( @array[ $i ] == $minimum ) {
          return $i ;
          }
        }
    }
      }
  }
}

sub find( @anArray , $number ) {
  my @found = @anArray.grep( { $_ == $number } ) ;
  return @found.elems ;
}

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
if ( $len == 1 ) {
  say @numbers[ 0 ] ;
}
else {
  my $theSum = 0 ;
  while ( $len > 1 ) {
      my $pos = findPos( @numbers ) ;
      if ( $pos == 0 ) {
    $theSum += @numbers[ $pos ] * @numbers[ $pos + 1 ] ;
      }
      if ( 1 <= $pos < $len - 1 ) {
    $theSum += @numbers[ $pos - 1 ] * @numbers[ $pos ] *
        @numbers[ $pos + 1 ] ;
      }
      if ( $pos == $len - 1 ) {
    $theSum += @numbers[ $len - 2 ] * @numbers[ $len - 1 ] ;
      }
      @numbers.splice( $pos , 1 , ( ) ) ;
      $len = @numbers.elems ;
  }
  $theSum += @numbers[ 0 ] ;
  say $theSum ;
}
