use v6 ;

sub createTree( Int $depth ) {
  return (1..(2 ** $depth) - 1 ).Array ;
}

#invert the tree level by level by reversing certain sections of the
#tree, corresponding to the different "floors" of the binary tree

sub invertTree( @array ) {
  my @inverted ;
  my $depth = log( @array.elems + 1 , 2 ) ;
  for ( 0..$depth - 1 ) -> $i {
      my @partialarray ;
      my $howmany = 2 ** $i ;
      if ( $howmany == 1 ) {
    @partialarray.push( @array.shift ) ;
      }
      else {
    for (1..$howmany) {
        @partialarray.push( @array.shift ) ;
    }
      }
      @partialarray .= reverse ;
      @inverted.push( @partialarray ) ;
  }
  return @inverted.flat ;
}

sub MAIN( Int $depth ) {
  say invertTree( createTree( $depth ) ) ;
}
