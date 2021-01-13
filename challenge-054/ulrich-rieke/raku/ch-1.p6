use v6 ;

sub MAIN( Int $n, Int $k ) {
  my $seq = (1..$n).permutations ;
  my $elNum = $seq.elems ;
  if ( $k > $elNum ) {
      say ( ) ;
  }
  else {
      say $seq[ $k - 1 ] ;
  }
}
