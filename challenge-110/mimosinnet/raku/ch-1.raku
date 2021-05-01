# https://perlweeklychallenge.org/blog/perl-weekly-challenge-110/

grammar PhoneNumber {
  token TOP    { \s* <prefix> \s <number> }
  token prefix { \d ** 4 | '+' \d\d | '(' \d\d ')' }
  token number { \d ** 10 }
}

sub challenge( Str $filename ) {
  $filename.IO.lines.grep({ PhoneNumber.parse( $_) });
}

multi sub MAIN( Str $filename ) {
  say 'OUTPUT: ';
  challenge($filename).map( *.say );
}

multi sub MAIN( 'challenge' ) {
  MAIN('phone_numbers.txt');
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;
  is challenge('phone_numbers.txt'), ( '0044 1148820341', ' +44 1148820341', '(44) 1148820341');
  done-testing;
}
