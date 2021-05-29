# https://perlweeklychallenge.org/blog/perl-weekly-challenge-114/

sub challenge($num ) {
  ($num^..^*).grep({ $_.base(2).comb.sum == $num.base(2).comb.sum }).head;
}

multi sub MAIN( $num ) {
  say 'Input: $N = ',$num;
  say 'Output:     ',challenge($num),"\n";
}

multi sub MAIN( 'challenge' ) {
  MAIN(3);
  MAIN(12);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge(3), 5;
  is challenge(12), 17;
  is challenge(240), 263;

  done-testing;
}
