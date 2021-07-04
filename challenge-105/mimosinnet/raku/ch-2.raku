# https://perlweeklychallenge.org/blog/perl-weekly-challenge-105
# TASK #2 › The Name Game

sub challenge( Str $name ) {

  my $bname = 'b' ~ $name.substr(1);
  my $fname = 'f' ~ $name.substr(1);
  my $mname = 'm' ~ $name.substr(1);

  given $name.split("",:skip-empty).head {
    when 'B' { $bname = $name.substr(1) }
    when 'F' { $fname = $name.substr(1) }
    when 'M' { $mname = $name.substr(1) }
  }

  qq:to/END/;
  $name, $name, bo-$bname,
  Bonana-fanna fo-$fname
  Fee fi mo-$mname
  $name!
  END

}

multi sub MAIN( Str $name ) {
  say 'Input: $name = "',$name,'"';
  say "Output: \n";
  say challenge($name);
}

multi sub MAIN( 'challenge' ) {
  MAIN('Katie');
}

multi sub MAIN( 't' ) {
  challenge('Fred').say;
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    ('Katie', "Katie, Katie, bo-batie,\nBonana-fanna fo-fatie\nFee fi mo-matie\nKatie!\n"),
    ('Valerie', "Valerie, Valerie, bo-balerie,\nBonana-fanna fo-falerie\nFee fi mo-malerie\nValerie!\n"),
    ('Billy', "Billy, Billy, bo-illy,\nBonana-fanna fo-filly\nFee fi mo-milly\nBilly!\n"),
    ('Fred', "Fred, Fred, bo-bred,\nBonana-fanna fo-red\nFee fi mo-mred\nFred!\n"),
    ('Marsha', "Marsha, Marsha, bo-barsha,\nBonana-fanna fo-farsha\nFee fi mo-arsha\nMarsha!\n")
  );

  for @test -> ($a, $b) {
    is challenge($a), $b;
  }

  done-testing;

}
