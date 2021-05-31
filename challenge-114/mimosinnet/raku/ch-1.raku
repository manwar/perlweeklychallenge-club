# https://perlweeklychallenge.org/blog/perl-weekly-challenge-114/

sub challenge( $number ) {
  ($number^..^∞).grep({ $_ eq $_.flip }).first;
}

multi sub MAIN( $number ) {
  say 'Input: $N = ',$number;
  say 'Output:     ',challenge($number),"\n";
}

multi sub MAIN( 'challenge' ) {
  MAIN(1234);
  MAIN(999);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge(1234), 1331;
  is challenge(999), 1001;
  is challenge(500006),501105;

  done-testing;
}
