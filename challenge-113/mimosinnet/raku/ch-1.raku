# https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/

#|
sub challenge( $n, $d ) {
  return (1..$n).grep( /$d/ ).combinations(1..*).map({ $_.sum }).grep($n).Bool.Int;
}

multi sub MAIN( $n where $n>0, $d where 1..9 ) {
  say sprintf('Input: $N = %d, $D = %d',$n,$d);
  say sprintf("Output: %d\n",challenge($n,$d));
}

multi sub MAIN( 'challenge' ) {
  MAIN(25,7);
  MAIN(24,7)
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge(25,7),0;
  is challenge(24,7),1;

  done-testing;
}
