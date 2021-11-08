# https://perlweeklychallenge.org/blog/perl-weekly-challenge-127

# Simplified the expresion using Ash solution
sub challenge( @s1, @s2 ) {
  return +!(@s1 ∩ @s2 );
}

multi sub MAIN( @s1, @s2 ) {
  say 'Input: @S1 = ',@s1;
  say '       @S2 = ',@s2;
  my $result = challenge( @s1, @s2);
  print 'Output: ',challenge( @s1, @s2),' as the given two sets ';
  ($result ?? 'do not have common member.' !! 'have at least a common member.' ).say;
}

multi sub MAIN( 'challenge' ) {
  MAIN( (1, 2, 5, 3, 4), (4, 6, 7, 8, 9) );
  MAIN( (1, 3, 5, 7, 9), (0, 2, 4, 6, 8) );
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    (1, 2, 5, 3, 4),    (4, 6, 7, 8, 9), 0,
    (1, 3, 5, 7, 9),    (0, 2, 4, 6, 8), 1,
    (1, 2, 5, 3, 4, 6), (4, 6, 7, 8, 9), 0 
  );

  for @test -> $a, $b, $c {
    is challenge($a,$b), $c;
  }

  done-testing;

}
