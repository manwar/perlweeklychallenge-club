# https://perlweeklychallenge.org/blog/perl-weekly-challenge-119
# TASK #2 › Sequence without 1-on-1

#|
sub challenge( UInt $n ) {
  my Str @numbers = (1..^∞).map({ .base(4) }).grep(none /0 | 11/);
  return @numbers[ $n -1 ];
}

multi sub MAIN( UInt $n ) {
  say 'Input: $N = ',$n;
  say 'Output:     ',challenge($n),"\n";
}

multi sub MAIN( 'challenge' ) {
  my UInt @challenge = ( 5, 10, 60 );

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    ( 5,   13),
    (10,   32),
    (60, 2223)
  );

  for @test -> ($a, $b) {
    is challenge($a), $b;
  }

  done-testing;

}
