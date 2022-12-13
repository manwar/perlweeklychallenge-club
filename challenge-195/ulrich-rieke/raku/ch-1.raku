use v6 ;

sub isSpecial( Int $n is copy --> Bool ) {
  if ( $n < 10 ) {
      return True ;
  }
  else {
      my %frequencies ;
      while ( $n != 0 ) {
    %frequencies{ $n % 10 }++ ;
    $n div= 10 ;
      }
      my @vals = %frequencies.values ;
      return @vals.grep( { $_ == 1 } ).elems == @vals.elems ;
  }
}

sub MAIN( Int $number ) {
  my $count = 0 ;
  for (1 .. $number ) -> $i {
      if ( isSpecial( $i ) ) {
    $count++ ;
      }
  }
  say $count ;
}
