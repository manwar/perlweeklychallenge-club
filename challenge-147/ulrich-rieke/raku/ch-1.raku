use v6 ;

sub isTruncatablePrime( Int $n is copy --> Bool ) {
  if ( ~$n ~~ /0/ ) {
      return False ;
  }
  elsif ( not $n.is-prime ) {
      return False ;
  }
  else {
      while ( $n.is-prime ) {
    if ( $n < 10 ) {
        return True ;
    }
    else {
        my $len = ~$n.chars ;
        $n = $n % ( 10 ** ( $len - 1 ) ) ;
    }
      }
  }
}

my @truncatables ;
my $current = 1;
while ( @truncatables.elems < 20 ) {
  $current++ ;
  if ( isTruncatablePrime( $current ) ) {
      @truncatables.push( $current ) ;
  }
}
say @truncatables ;
