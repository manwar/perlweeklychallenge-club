# https://perlweeklychallenge.org/blog/perl-weekly-challenge-108/
# Inspired by Luca Ferrari

sub challenge( $var ) {
  $var.WHERE;
}

multi sub MAIN( $var ) {
  my $mem = challenge($var);
  say sprintf " Var:    Value: \"%s\"; Type: %s \n Memory: Bin:%#b; Oct:%#o; Dec:%d, Hex:%#x", $var, $var.^name, $mem, $mem, $mem, $mem; 
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my $var = 'This is a test';
  is challenge($var), $var.WHERE;

  done-testing;

}
