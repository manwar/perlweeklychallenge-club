# https://perlweeklychallenge.org/blog/perl-weekly-challenge-106/

multi sub challenge( @n where @n.elems == 1) { return 0 }
multi sub challenge( @n                    ) {
  return @n.sort.rotor( 2 => -1).map( -> ($a, $b) { $b - $a }).max;
}

multi sub MAIN( @n ) {
  say 'Input:  ',@n;
  say 'Output: ',challenge(@n),"\n";
}

multi sub MAIN( 'challenge' ) {
  my @challenge = (
    (2, 9, 3, 5)   ,
    (1, 3, 8, 2, 0),
    (5,)           
  );

  for @challenge -> @a {
    MAIN(@a);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    ( (2, 9, 3, 5)   , 4,'Example 1' ),
    ( (1, 3, 8, 2, 0), 5,'Example 2' ),
    ( (5,)           , 0,'Example 3' )
  );

  for @test -> (@a, $b, $c) {
    is challenge(@a),$b,$c;
  }
 
}
