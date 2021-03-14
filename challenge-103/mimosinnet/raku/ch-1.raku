# https://perlweeklychallenge.org/blog/perl-weekly-challenge-103/

class ChineseZodiac {
  has $.year;
  has @!animals  = <Monkey Rooster Dog Pig Rat Ox Tiger Rabbit Dragon Snake Horse Goat>;
  has @!elements = <Metal Water Wood Fire Earth>;


  method chinese-zodiac() {
    return sprintf('%s %s', @!elements[ floor( $!year / 2 % 5 ) ], @!animals[ $!year % 12 ]);
  }
}

multi sub MAIN( $year ) {
  say 'Input: ',$year;
  say sprintf("Output: %s\n",ChineseZodiac.new( year => $year ).chinese-zodiac);
}

multi sub MAIN( 'challenge' ) {
  my @challenge = < 2017 1938 >;

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my %test = 
    2017, 'Fire Rooster',
    1938, 'Earth Tiger'
  ;

  for %test.keys -> $a {
    is ChineseZodiac.new( year => $a ).chinese-zodiac, %test{$a};
  }
}
