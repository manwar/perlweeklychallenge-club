# https://perlweeklychallenge.org/blog/perl-weekly-challenge-115/

# Find the lowest multiple of 2 and sort the rest of numbers
sub challenge( @numbers ) {
  my $last_number   = @numbers.sort.first({ $_ %% 2 });
  my @other_numbers = @numbers.grep(none $last_number).sort({ $^b leg $^a });
  @other_numbers.push: $last_number;
  return @other_numbers.join;
}

multi sub MAIN( @numbers ) {
  say 'Input:  @N = ',@numbers;
  say 'Output: ',challenge(@numbers),"\n";
}

multi sub MAIN( 'challenge' ) {

  my @challenge = (
    (1, 0, 2, 6),
    (1, 4, 2, 8),
    (4, 1, 7, 6)
  );

  for @challenge -> @a {
    MAIN(@a);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    (1, 0, 2, 6), 6210,
    (1, 4, 2, 8), 8412,
    (4, 1, 7, 6), 7614
  );

  for @test -> @a, $b {
    is challenge(@a), $b;
  }

  done-testing;

}
