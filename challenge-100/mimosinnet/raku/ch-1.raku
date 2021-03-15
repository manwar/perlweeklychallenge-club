# https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/

grammar Time 
{
  token TOP  { <time>\s?<meri>? }
  token time { <hour>\:<mins>  }
  token hour { \d ** {2} }
  token mins { \d ** {2} }
  token meri { am || pm }
}

#|
sub challenge( $time) {
  my $match = Time.parse($time);
  given $match<meri> {
    when 'am' { return $match<time>.Str; }
    when 'pm' { return sprintf "%02d:%02d", $match<time><hour>.Num + 12, $match<time><mins>;}
    default {
      return sprintf "%02d:%02d%02s", $match<time><hour> - 12, $match<time><mins>, 'pm' if $match<time><hour> > 12;
      return sprintf "%02d:%02d%02s", $match<time><hour>     , $match<time><mins>, 'am';
    }
  }
}

multi sub MAIN( $time ) {
  say 'Input:  ', $time;
  say 'Output: ', challenge( $time ), "\n";
}

multi sub MAIN( 'challenge' ) {
 my @challenge = (
    '05:15 pm',
    '05:15pm' ,
    '05:15am' ,
    '19:15'
  );

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' ) {
  use Test;

  my @test = (
    ('05:15 pm', '17:15'   ),
    ('05:15pm' , '17:15'   ),
    ('19:15'   , '07:15pm' )
  );

  for @test -> ($a, $b ) {
    is challenge($a), $b;
  }
}
