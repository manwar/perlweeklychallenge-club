# https://perlweeklychallenge.org/blog/perl-weekly-challenge-104/

multi sub challenge( $n ) {
  return 0 if $n == 0;
  return 1 if $n == 1;
  return challenge( $n /2) if $n %% 2;
  return challenge( ($n-1) / 2 ) + challenge( ($n+1) / 2 );
}

multi sub MAIN( $n ) {
  ( 0..($n-1 ) ).map({ challenge($_) }).say;
}

multi sub MAIN( 'challenge' ) {
  MAIN( 50 );
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

	my @fusc = <0  1  1  2  1  3  2  3  1  4  3  5  2  5  3  4  1  5  4  7  3  8  5  7  2  7  5  8  3  7  4  5  1  6  5  9  4  11  7  10  3  11  8  13  5  12  7  9  2  9  7  12  5  13  8  11  3  10  7  11  4  9  5  6  1  7  6  11  5  14  9  13  4  15  11  18  7  17  10  13  3  14  11  19  8  21  13  18  5  17  12  19>;

  ( 0..(@fusc.elems -1) ).map({ is challenge($_),@fusc[$_],@fusc[$_] });
}
