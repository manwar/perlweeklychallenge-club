use v6 ;

sub MAIN(Int $N is copy ) {
  my @combinations = gather {
      for ( 1 .. 100 ) -> $i {
    for ( 1 .. 100 ) -> $j {
        for ( 1 .. 100 ) -> $k {
          if ( $N == $i || $N == $j || $N == $k ) {
          if ( $i ** 2 + $j ** 2 == $k ** 2 ) {
            take sort ( $i , $j , $k ) ;
          }
          }
        }
    }
      }
  }
  if ( @combinations ) {
      .say for @combinations.map( {.Array} ).unique( :with(&[eqv] ) ) ;
  }
  else {
      say -1 ;
  }
}
