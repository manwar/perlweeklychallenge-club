# https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/

my $tab = " " x 5;

sub challenge( UInt $n ) {
  return (1..$n).grep( * !~~ /1/);
}

multi sub MAIN( UInt $n ) {
  say 'Input: $N = ',$n;
  my @result = challenge($n);
  say 'Output: ',@result.elems;
  say $tab,"There are {@result.elems} numbers between 1 and $n that don't contain digit 1.";
  print $tab;
  @result.map({ print "$_, "});
  say "\n",$tab,'-' x 70,"\n";
}

multi sub MAIN( 'challenge' ) {
  my @challenge = ( 15, 25 );

  for @challenge {
    MAIN($_);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    (15, <2 3 4 5 6 7 8 9> ),
    (25, <2 3 4 5 6 7 8 9 20 22 23 24 25>)
  );

  for @test -> ($a, $b) {
    is challenge($a), $b;
  }

  done-testing;

}
