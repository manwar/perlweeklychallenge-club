# https://perlweeklychallenge.org/blog/perl-weekly-challenge-110/

sub challenge( Str $filename ) {
  [Z] $filename.IO.lines.map( *.split(',') );
}

multi sub MAIN( Str $filename ) {
  say 'Output: ';
  challenge($filename).map( *.join(',').say );
}

multi sub MAIN( 'challenge' ) {
  MAIN('names.txt');
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge('names.txt'), (<name Mohammad Joe Julie Cristina>,<age 45 20 35 10>,<sex m m f f>);

  done-testing;
}
