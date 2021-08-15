# https://perlweeklychallenge.org/blog/perl-weekly-challenge-125/

# Euclid's method for finding Pythagorean Triples
# a = m2 – n2, b = 2mn, c = m2 + n2 (assuming m > n)
# https://schoolbag.info/mathematics/numbers/79.html

# The Euclid's approach does not seem to work.
# It solves the tests of the challenge, but it does not find "all" of the 
# Pythagorean Triples. See Mark Anderson's solution.

sub challenge( UInt $num ) {
  return -1 if $num ∈ (1, 2);
  gather {
    # Pythagorean Triples of $num are bigger than $m² 
    for 1..$num -> $m {
      for 1..^$num -> $n {
        next if $n >= $m;
        my @pt = ($m² - $n², 2 * $m * $n, $m² + $n²);
        take @pt.sort if $num ∈ @pt;
      }
    }
  };
}

# Odd:
#  Works:         $ raku ch1.raku challenge 
#  Does not Work: $ raku ch1.raku 13  
multi sub MAIN( UInt $N ) {
  say "\nInput: ",'$N = ',$N;
  say 'Output: ';
  for challenge($N) -> $output {
    say "\t ",$output.gist;
  }
}

multi sub MAIN( 'challenge' ) {
  my @challenge = (5, 13, 1);

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    5, ( 3, 4, 5; 5, 12, 13 ), 
    13, ( 5, 12, 13; 13, 84, 85 ),
    1, -1;
  );

  for @test -> $a, $b {
    is challenge($a), $b;
  }

  done-testing;

}
