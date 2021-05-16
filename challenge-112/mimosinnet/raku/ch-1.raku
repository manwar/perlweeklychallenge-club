# https://perlweeklychallenge.org/blog/perl-weekly-challenge-112/

sub challenge( Str $path ) {
  return   IO::Spec::Unix.canonpath($path, :parent);
}

multi sub MAIN( Str $path ) {
  say 'Input:  "',$path,'"';
  say 'Output: "',challenge($path),"\"\n";
}

multi sub MAIN( 'challenge' ) {
  my @challenge = < /a /a/b//c/ /a/b/c/../.. >;

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    </a           /a>,
    </a/b//c/     /a/b/c>,
    </a/b/c/../.. /a>
  );

  for @test -> ($a, $b) {
    is challenge($a), $b;
  }

  done-testing;
}
