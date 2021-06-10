# https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/

# Got the insiration from Luca Ferrari and Ulrigh Rieke
# Luca's solution is quite neat! 

sub challenge( @strings ) {
  my @letter_first = @strings.map({ $_.comb.Array.shift });
  my @letter_last  = @strings.map({ $_.comb.Array.pop   });
  (@letter_first.sort ~~ @letter_last.sort).Numeric;
}

multi sub MAIN( @strings ) {
  say 'Input: @S = ',@strings;
  say 'Output: ',challenge(@strings),"\n";
}

multi sub MAIN( 'challenge' ) {

  my @challenge = (
    <abc dea cd>,
    <ade cbd fgh>
  );

  for @challenge -> @a {
    MAIN(@a);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = [
    <abc dea cd>,      1, 
    <ade cbd fgh>,     0, 
    <abc dea fgh hif>, 0, 
    <abc dec cfa cgd>, 1, 
    <abc def cd>,      0
  ];

  for @test -> @a, $b {
    is challenge(@a), $b;
  }

  done-testing;

}
