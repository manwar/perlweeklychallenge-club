# https://perlweeklychallenge.org/blog/perl-weekly-challenge-106/

# see: https://docs.raku.org/routine/base-repeating
sub challenge( $a, $b ) {
  my ($non-rep, $repeating) = ( $a / $b).base-repeating;
  return  $non-rep if $repeating eq '';
  return "$non-rep\($repeating\)";
}

multi sub MAIN( $n, $d ) {
  say 'Input:   $N = ',$n,', $D = ',$d;
  say 'Output: "',challenge($n,$d),"\"\n";
}

multi sub MAIN( 'challenge' ) {
  my @challenge = (
    (1,  3),
    (1,  2),
    (5, 66) 
  );

  for @challenge -> ($a, $b) {
    MAIN($a,$b);
  }
}

multi sub MAIN( 'test' ) is hidden-from-USAGE {
  use Test;

  my @test = (
    (1,  3, '0.(3)'  ),
    (1,  2, '0.5'    ),
    (5, 66, '0.0(75)') 
  );

  for @test -> ($a, $b, $c ) {
    is challenge($a,$b), $c;
  }
 
}
