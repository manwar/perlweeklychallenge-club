# https://perlweeklychallenge.org/blog/perl-weekly-challenge-108 Task 2

# I could not solve this challenge so I have looked at the other solutions.
# I have noticed that most of the solutions follow the Triangle scheme for calculations [1]
# except Aaron Smith [2].
#
# I have been rewriting Aaron Smith code to see if I could understand it! 
# Very impressive to see the translation of the Bell formula to Raku code!
# (specially when coming from social siences. Really nice!)
#
# [1] https://en.wikipedia.org/wiki/Bell_number#Triangle_scheme_for_calculations
# [2] https://aaronreidsmith.github.io/blog/perl-weekly-challenge-108/

my $l = Lock.new;
my %bell-cached;
sub challenge( $number ) {
  return 1 if $number == 0|1;

  my $previous-bell-number = $number - 1;
  my @partitions = gather {
    for (0..$previous-bell-number) -> $k {
      take ( 
        (0..^$previous-bell-number).combinations($k).elems * ( %bell-cached{$k} //= challenge($k) )
      );
    }
  }
  return @partitions.sum;
}

multi sub MAIN( $number ) {
    say "The number of partitions of a set of size $number is: ",challenge($number);
}

multi sub MAIN( 'challenge' ) {
  for (1..10) -> $number {
    MAIN($number);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @tests = (
      (0, 1),
      (1, 1),
      (2, 2),
      (3, 5),
      (4, 15),
      (5, 52),
      (6, 203),
      (7, 877),
      (8, 4140),
      (9, 21147),
      (10, 115975)
  );

  for @tests -> ($n, $bell-number) {
      is(challenge($n), $bell-number);
  }

  done-testing;

}
