# https://perlweeklychallenge.org/blog/perl-weekly-challenge-09X/

#|
sub challenge( @triangle ) {
  return ([X+] @triangle[*]).min;
}

multi sub MAIN( @triangle ) {
  say 'Input: Triangle = ', @triangle;
  say 'Output: ', challenge(@triangle),"\n";

}

multi sub MAIN( 'challenge' ) {
  my @challenge = (
    [ [1], [2,4], [6,4,9], [5,1,7,2] ], 
    [ [3], [3,1], [5,2,3], [4,3,1,3] ]
  );

  for @challenge -> @a {
    MAIN(@a);
  }
}

multi sub MAIN( 't' ) {
}

multi sub MAIN( 'test' ) {
  use Test;

  my @test = (
    ([ [1], [2,4], [6,4,9], [5,1,7,2] ], 8),
    ([ [3], [3,1], [5,2,3], [4,3,1,3] ], 7)
  );

  for @test -> ($a, $b ) {
    is challenge($a), $b;
  }
 
}
