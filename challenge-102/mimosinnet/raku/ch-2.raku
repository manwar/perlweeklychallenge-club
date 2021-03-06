# https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/

multi sub challenge( 1 )  { return '#'   }
multi sub challenge( 2 )  { return '2#'  }
multi sub challenge( $N ) { return challenge( $N - ($N.chars + 1) ) ~ $N ~ '#' }

multi sub MAIN( Int $N ) {
  say '"',challenge($N),'" is the counting string of length ',$N;
}

multi sub MAIN( 'challenge' ) {
  my @challenge = 1, 2, 3, 10, 14;

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' ) is hidden-from-USAGE {
  use Test;

  my %test = 
    1, '#',
    2, '2#',
    3, '#3#',
    10, '#3#5#7#10#',
    14, '2#4#6#8#11#14#'
  ;

  for %test.keys -> $key {
    is challenge($key.Int), %test{$key};
  }
 
}
