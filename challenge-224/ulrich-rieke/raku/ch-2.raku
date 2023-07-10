use v6 ;
use Math::Combinatorics <partitions> ;

sub isAdditive( @array ) {
  my $len = @array.elems ;
  if ( $len <= 2 ) {
      return False ;
  }
  else {
      for (2..$len - 1 ) -> $i {
    if ( @array[ $i - 2 ] + @array[ $i - 1 ] != @array[ $i ] ) {
        return False ;
    }
      }
      return True ;
  }
}

#the library function partitions n provides all possible combinations of
#numbers 1 to n that add up to n. We extract the corresponding substrings
#from the original string that was entered.
sub extractArray( $string , $seq ) {
  my @array ;
  my $pos = 0 ;
  for (0..$seq.elems - 1) -> $i {
      @array.push( $string.substr($pos , $seq[ $i ] ).Int ) ;
      $pos += $seq[ $i ] ;
  }
  return @array ;
}

say "Enter a string consisting of digits 0 to 9 only!" ;
my $line = $*IN.get ;
my $len = $line.chars ;
my @partitions = partitions( $len ) ;
for @partitions -> $part {
  my @numArray = extractArray( $line , $part ) ;
  if ( isAdditive( @numArray ) ) {
      say "true" ;
      exit( 0 ) ;
  }
}
say "false" ;
