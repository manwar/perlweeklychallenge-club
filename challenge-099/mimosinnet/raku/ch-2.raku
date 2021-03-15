# https://perlweeklychallenge.org/blog/perl-weekly-challenge-099/

# I have been stuck for a while in this challenge,
# and I have looked at aaronreidsmith solution.
# This is based on aaronreidsmith.

#|
sub challenge( $string, $pattern is copy ) {
  $pattern = $pattern.comb.join('.*') ;
  $string.match( /<$pattern>/, :exhaustive).elems;
}

multi sub MAIN( $string, $pattern ) {
  say 'Input: $S = "',$string,'", $T = "',$pattern,'"';
  say 'Output: ',challenge($string,$pattern),"\n";
}

multi sub MAIN( 'challenge' ) {
  my @challenge = (
    ( 'littleit', 'lit' ),
    ( 'london'  , 'lon' )
  );

  for @challenge -> ($a, $b) {
    MAIN( $a, $b);
  }
}

multi sub MAIN( 'test' ) {
  use Test;

  my @test = (
    ( 'littleit', 'lit', 5 ),
    ( 'london'  , 'lon', 3 )
  );

  for @test -> ($a, $b, $c) {
    is challenge( $a, $b), $c;
  }
 
}
