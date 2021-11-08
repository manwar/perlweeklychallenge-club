# https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/
# TASK #1 › Swap Nibbles

sub challenge( $n ) {
  my @nibble = (sprintf('%08d',$n.base(2)) ~~ / (\d ** 4) (\d ** 4) /).List ;
  return (@nibble[1].Str ~ @nibble[0].Str).parse-base(2);
}

multi sub MAIN( $n ) {
  say 'Input: $N = ',$n;
  say 'Output:     ',challenge($n),"\n";
}

multi sub MAIN( 'challenge' ) {
  MAIN(101);
  MAIN(18);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    (101, 86),
    ( 18, 33)
  );

  for @test -> ($a, $b) {
    is challenge($a), $b;
  }

  done-testing;
}
