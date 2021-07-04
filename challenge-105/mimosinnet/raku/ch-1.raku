# https://perlweeklychallenge.org/blog/perl-weekly-challenge-105/
# TASK #1 › Nth root


sub challenge( $n, $k ) {
  return (sprintf '%.2f', $k ** ( 1 / $n)).Num;
}

multi sub MAIN( $n, $k ) {
  say 'Input: $N = ',$n,' $k = ',$k;
  say 'Output: ',challenge($n, $k),"\n";
}

multi sub MAIN( 'challenge' ) {
  my @challenge = (
    (5, 248832),
    (5,     34)
  );

  for @challenge -> ($a, $b) {
    MAIN($a,$b);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    (5, 248832, 12),
    (5,     34,  2.02)
  );

  for @test -> ($a, $b, $c ) {
    is challenge($a,$b), $c;
  }

  done-testing;

}
