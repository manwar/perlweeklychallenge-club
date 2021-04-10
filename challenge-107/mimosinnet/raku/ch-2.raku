# https://perlweeklychallenge.org/blog/perl-weekly-challenge-10X/

# This is from Luca Ferrari
sub challenge( $class ) {
  return ::($class).^methods( :local ).sort.gist.substr(1,*-1);
}

multi sub MAIN( Str $class ) {
  say 'Class: ',$class;
  say 'Methods: ',challenge($class);
}

multi sub MAIN( 'challenge' ) {
  MAIN('Calc');
}

multi sub MAIN( 'test' ) is hidden-from-USAGE {
  use Test;

  class Calc {
    method add() { }
    method mul() { }
    method div() { }
  }

  my @test = (
    'Calc', 'BUILDALL add div mul'
  );

  for @test -> $a, $b {
    is challenge($a),$b;
  }
}
