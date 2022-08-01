use v6 ;


sub isPermutedMultiple( Int $n is copy --> Bool ) {
  my Int $mult = 2 ;
  my $startDigits = ~$n.comb.sort.join ;
  while ( $mult != 6 ) {
      my $productDigits = ~($n * $mult).comb.sort.join ;
      if ( $productDigits ne $startDigits ) {
    return False ; #enforce early termination of loop
      }
      $mult++ ;
  }
  if ( ~($n * 6).comb.sort.join eq $startDigits ) {
      return True ;
  }
  else {
      return False ;
  }
}

my Int $current = 0 ;
repeat {
  $current++ ;
} until isPermutedMultiple( $current ) ;
say $current ;
